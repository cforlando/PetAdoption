//
//  HomeViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import Toast_Swift
import PetAdoptionTransportKit

class PetListingViewController: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - Constants
    ////////////////////////////////////////////////////////////

    static let SEGUE_TO_PET_DETAILS_ID = "segueToPetDetails"
    static let SEGUE_TO_NEW_PET_DETAILS_ID = "segueToNewPetDetails"

    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewSwitch: UISwitch!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var petData = [PTKPet]()
    var viewControllerTitle = "Home"
    let requestManager = PTKRequestManager.sharedInstance()
    var segueIdentifier = PetListingViewController.SEGUE_TO_PET_DETAILS_ID

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.collectionView.collectionViewLayout = CustomHomeCollectionViewFlowLayout()

        requestManager.request(AllPetsWithcompletion:
        { pets, error in
            if let error = error
            {
                self.view.makeToast(error.localizedDescription)
            }
            else
            {
                if let pets = pets
                {
                    self.petData = pets
                    self.collectionView.reloadData()
                }
            }
        })
    }

    ////////////////////////////////////////////////////////////

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationItem.title = NSLocalizedString("Town Of Lady Lake", comment: "")
    }

    ////////////////////////////////////////////////////////////

    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationItem.title = NSLocalizedString("Back", comment: "")
    }

    ////////////////////////////////////////////////////////////
    // MARK: - IBActions
    ////////////////////////////////////////////////////////////

    @IBAction func switchToggled(sender: AnyObject)
    {
        self.segueIdentifier = viewSwitch.on ? PetListingViewController.SEGUE_TO_NEW_PET_DETAILS_ID : PetListingViewController.SEGUE_TO_PET_DETAILS_ID
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let vc = segue.destinationViewController as? NewPetListingDetailVC
            where segue.identifier == PetListingViewController.SEGUE_TO_NEW_PET_DETAILS_ID,
           let indexPath = sender as? NSIndexPath
        {
            vc.pet = self.petData[indexPath.row]
        }
        else if let vc = segue.destinationViewController as? PetListingDetailViewController
            where segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID,
            let indexPath = sender as? NSIndexPath
        {
            vc.pet = self.petData[indexPath.row]
        }
    }
}

////////////////////////////////////////////////////////////

extension PetListingViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.petData.count
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PetCell.reuseIdentifier, forIndexPath: indexPath) as! PetCell
        let pet = petData[indexPath.row]
        cell.configureCell(with: pet)
		
        return cell
    }

    ////////////////////////////////////////////////////////////

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier(segueIdentifier, sender: indexPath)
    }
}
