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
        self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.collectionView.collectionViewLayout = HomePortraitCollectionViewLayout()
        
        refreshControl.addTarget(self, action: #selector(refreshTriggered), forControlEvents: .ValueChanged)
        self.collectionView.addSubview(refreshControl)
        
        loadPets()
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

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)

        let currentOrientation = UIDevice.currentDevice().orientation
        let isLandscape = (currentOrientation == .LandscapeLeft) || (currentOrientation == .LandscapeRight)
        let newLayout = isLandscape ? HomeLandscapeCollectionViewLayout() : HomePortraitCollectionViewLayout()

        coordinator.animateAlongsideTransition(nil)
        { context in
            self.collectionView.setCollectionViewLayout(newLayout, animated: true)
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Navigation
    ////////////////////////////////////////////////////////////

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let vc = segue.destinationViewController as? PetListingDetailVC
            where segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID,
            let indexPath = sender as? NSIndexPath
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
                
                self.refreshControl.endRefreshing()
        })
    }
    
    func refreshTriggered() {
        loadPets()
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
        performSegueWithIdentifier(PetListingViewController.SEGUE_TO_PET_DETAILS_ID, sender: indexPath)
    }
}
