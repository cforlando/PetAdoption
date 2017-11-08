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

class PetListingViewController: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - Constants
    ////////////////////////////////////////////////////////////

    static let SEGUE_TO_PET_DETAILS_ID = "segueToPetDetails"

    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var collectionView: UICollectionView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var petData = [PTKPet]()
    var viewControllerTitle = "Home"
    let requestManager = PTKRequestManager.sharedInstance()

    let refreshControl = UIRefreshControl()

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
        
        loadPets()
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = NSLocalizedString("Town Of Lady Lake", comment: "")
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
        if let vc = segue.destination as? PetListingDetailVC, segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID,
            let indexPath = sender as? IndexPath
        {
            vc.pet = self.petData[indexPath.row]
        }
    }
    
    // Helper methods
    func loadPets() {
        requestManager.request(AllPetsWithcompletion:
            { pets, error in
                if let error = error
                {
                    print(error.localizedDescription)
                }
                else
                {
                    if let pets = pets
                    {
                        self.petData = pets
                        self.collectionView.reloadData()
                    }
                }
                
                self.refreshControl.endRefreshing()
        })
    }
    
    @objc func refreshTriggered() {
        loadPets()
    }
}

////////////////////////////////////////////////////////////

extension PetListingViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.petData.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCell.reuseIdentifier, for: indexPath) as! PetCell
        let pet = petData[indexPath.row]
        cell.configureCell(with: pet)
		
        return cell
    }

    ////////////////////////////////////////////////////////////

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: PetListingViewController.SEGUE_TO_PET_DETAILS_ID, sender: indexPath)
    }
}
