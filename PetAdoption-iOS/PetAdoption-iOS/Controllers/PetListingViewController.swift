//
//  HomeViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit
import AlamofireImage

class PetListingViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - Constants
    ////////////////////////////////////////////////////////////

    static let SEGUE_TO_PET_DETAILS_ID = "segueToPetDetails"

    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    
    @IBOutlet weak var noResultsLabel: UILabel!
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var petData = [PFPet]()
    var filteredPetData = [PFPet]()
    var viewControllerTitle = "Home"
    let requestManager = PTKRequestManager.sharedInstance()
    var lastOffset: String?

    let refreshControl = UIRefreshControl()
    var isLastPage = false
    @objc weak var actionToEnable : UIAlertAction?

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = UIColor.groupTableViewBackground
        self.collectionView.collectionViewLayout = HomePortraitCollectionViewLayout()
        
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        
        if let _ = UserDefaults.standard.string(forKey: Constants.ZIPCODE_KEY)
        {
            loadPets(offset: lastOffset)
        }
        else
        {
            presentZipCodeAlertController()
        }
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if let zipCode = UserDefaults.standard.string(forKey: Constants.ZIPCODE_KEY)
        {
            setNavigationTitle("Pets near \(zipCode)")
        }
        else
        {
            setNavigationTitle("Pet Adoption")
        }
    }

    ////////////////////////////////////////////////////////////

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationItem.title = NSLocalizedString("Back", comment: "")
    }

    ////////////////////////////////////////////////////////////

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)

        let currentOrientation = UIDevice.current.orientation
        let newLayout = UIDeviceOrientationIsLandscape(currentOrientation) ? HomeLandscapeCollectionViewLayout() : HomePortraitCollectionViewLayout()

        coordinator.animate(alongsideTransition: nil)
        { context in
            self.collectionView.setCollectionViewLayout(newLayout, animated: true)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? PetListingDetailVC,
            segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID,
            let indexPath = sender as? IndexPath
        {
            vc.pet = self.filteredPetData[indexPath.row]
        }
    }
    
    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////
    
    @IBAction func locationButtonTapped(_ sender: Any)
    {
        presentZipCodeAlertController()
    }

    @IBAction func filterButtonTapped(_ sender: UIBarButtonItem) {
        presentFilterViewController()
    }
    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func zipCodeIsValid(str:String) -> Bool
    {
        let zipRegEx = "^\\d{5}([ \\-]\\d{4})?"
        let zipCodeTest = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
        return zipCodeTest.evaluate(with: str)
    }

    ////////////////////////////////////////////////////////////

    @objc func textChanged(_ sender:UITextField)
    {
        self.actionToEnable?.isEnabled = zipCodeIsValid(str: sender.text!)
    }

    ////////////////////////////////////////////////////////////

    func presentZipCodeAlertController()
    {
        let alertController = UIAlertController(title: "Set Location", message: "Please enter your zip code", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let zipCodeAction = UIAlertAction(title: "OK", style: .default)
        { [unowned alertController] _ in
            let zipText = alertController.textFields![0]
            if let zipCode = zipText.text
            {
                UserDefaults.standard.set(zipCode, forKey: Constants.ZIPCODE_KEY)
                self.setNavigationTitle("Pets near \(zipCode)")
            }
            self.loadPets()
        }
        
        alertController.addTextField
        { textField in
                textField.placeholder = "Zip Code"
                textField.keyboardType = .numberPad
                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(zipCodeAction)
        self.actionToEnable = zipCodeAction
        zipCodeAction.isEnabled = false
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentFilterViewController()
    {
        guard let filterVC = storyboard?.instantiateViewController(withIdentifier: "filterVC") as? FilterViewController else {fatalError("Error: could not instantiate filterVC")}
        filterVC.delegate = self
        filterVC.modalPresentationStyle = UIModalPresentationStyle.popover
        let popVC = filterVC.popoverPresentationController!
        popVC.delegate = self
        popVC.barButtonItem = filterBarButton
        self.present(filterVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    ////////////////////////////////////////////////////////////

    func setNavigationTitle(_ title: String)
    {
        self.navigationItem.title = NSLocalizedString(title, comment: "")
    }
    
    ////////////////////////////////////////////////////////////

    func loadPets(offset: String? = nil)
    {
        // reset will be used to determine if we need to empty our data source,
        // the assumption being that if we are not passing an offset to this function,
        // then we are either refreshing the list or creating a new list from a new zip code
        let reset = (offset == nil) ? true : false
        
        guard let zipCode = UserDefaults.standard.string(forKey: Constants.ZIPCODE_KEY) else { return }
        requestManager.request(PetFinderPetsFrom: zipCode, offset: offset)
        { pets, lastOffset, error in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {
                if let pets = pets
                {
                    if reset
                    {
                        self.petData = [PFPet]()
                        self.filteredPetData = [PFPet]()
                    }
                    
                    self.petData += pets
                    self.setFilteredAnimalTypes()
                    self.collectionView.reloadData()
                }
                
                if let lastOffset = lastOffset
                {
                    self.lastOffset = lastOffset
                }
            }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadNextItems() {
        if let lastOffset = self.lastOffset,
            let offset = Int(lastOffset) // this conversion is here simply to accommodate for the comparison below
        {
            if offset < Constants.MAX_SEARCH_RESULTS
            {
                loadPets(offset: lastOffset)
                self.isLastPage = false
            }
            else
            {
                self.isLastPage = true
            }
        }
    }
    
    ////////////////////////////////////////////////////////////

    @objc func refreshTriggered()
    {
        loadPets()
    }
}

////////////////////////////////////////////////////////////
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
////////////////////////////////////////////////////////////

extension PetListingViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        self.noResultsLabel.isHidden = !(self.filteredPetData.count == 0)
        return self.filteredPetData.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCell.reuseIdentifier, for: indexPath) as! PetCell
        let pet = filteredPetData[indexPath.row]
        cell.configureCell(with: pet)
		
        return cell
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: PetListingViewController.SEGUE_TO_PET_DETAILS_ID, sender: indexPath)
    }
    
    ////////////////////////////////////////////////////////////
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.item == self.filteredPetData.count - 1
        {
            loadNextItems()
        }
    }
    
    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let loadingView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: LoadingPetsView.reuseIdentifier, for: indexPath) as! LoadingPetsView
        
        if self.isLastPage
        {
            loadingView.activityIndicator.stopAnimating()
        }
        else
        {
            loadingView.activityIndicator.startAnimating()
        }
        
        return loadingView
    }
    
    func setFilteredAnimalTypes(){
        let animalTypesSelected = FilterViewController.loadAnimalTypesSelected()
        if animalTypesSelected.contains("all") {
            self.filteredPetData = petData
        } else {
            self.filteredPetData = petData.filter {(pet:PFPet) -> Bool in
                return animalTypesSelected.contains(pet.animalType.rawValue)
            }
        }
        
        collectionView.reloadData()
    }
}

extension PetListingViewController: FilterSelectorDelegate {
    func didChangeAnimalTypeSelections() {
        self.setFilteredAnimalTypes()
    }
}
