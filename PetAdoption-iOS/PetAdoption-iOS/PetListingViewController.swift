//
//  HomeViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import Toast_Swift

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

    var petData = [Pet]()
    var viewControllerTitle = "Home"

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Town Of Lady Lake", comment: "")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.collectionView.collectionViewLayout = CustomHomeCollectionViewFlowLayout()

        //Load some data (fake data for now)
        let petService = FindPetsService()
        petService.execute()
        { result in
            if (result.code == .Success)
            {
                self.petData = result.petsFound
                self.collectionView.reloadData()
            }
            else
            {
                self.view.makeToast("There was a problem fetching pet data")
            }
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let vc = segue.destinationViewController as? PetListingDetailViewController
            where segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID
        {
            vc.pet = sender as? Pet
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
        let pet = petData[indexPath.row]
        performSegueWithIdentifier(PetListingViewController.SEGUE_TO_PET_DETAILS_ID, sender: pet)
    }
}
