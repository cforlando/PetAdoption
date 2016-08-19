//
//  HomeViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class PetListingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
	static let SEGUE_TO_PET_DETAILS_ID = "segueToPetDetails"

	@IBOutlet weak var collectionView: UICollectionView!
	
	var petData : [Pet] = []
	let collectionViewCellId = "normal-cell"
	var viewControllerTitle: String = "Home"
	
	required init?(coder aDecoder: NSCoder)
    {
		super.init(coder: aDecoder);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PetListingViewController.showPetDetails(_:)), name: PetImageCollectionViewCell.DID_TAP_ON_PET_CELL_NOTIFICATION, object: nil)
	}
	
	override func viewDidLoad()
    {
		super.viewDidLoad()
		self.navigationItem.title = NSLocalizedString("Town Of Lady Lake", comment: "")
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
		self.collectionView.collectionViewLayout = CustomHomeCollectionViewFlowLayout()
		self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		
		let normalCellView = UINib(nibName: "PetImageCollectionViewCell", bundle: nil)
		self.collectionView.registerNib(normalCellView, forCellWithReuseIdentifier: collectionViewCellId)

		//Load some data (fake data for now)
		let petService = FindPetsService()
		petService.execute({ (result) -> Void in
			if (result.code == .Success) {
				self.petData = result.petsFound
				self.collectionView.reloadData()
			}
			else {
				//TODO: Handle error case
			}
		})
	}
	
	// MARK: - NSNotification listeners
	func showPetDetails(notification : NSNotification)
    {
		let visible = (self.isViewLoaded() && self.view.window != nil)
		if visible
        {
			let pet = notification.object as! Pet
			self.performSegueWithIdentifier(PetListingViewController.SEGUE_TO_PET_DETAILS_ID, sender: pet)
		}
	}
	
	// MARK: - Navigation delegate
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
		if (segue.identifier == PetListingViewController.SEGUE_TO_PET_DETAILS_ID)
        {
			let detailsVC = segue.destinationViewController as! PetListingDetailViewController
			detailsVC.pet = sender as! Pet
		}
	}
	
	// MARK: - UICollectionViewDataSource and Delegate
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
		return self.petData.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellId, forIndexPath: indexPath) as? PetImageCollectionViewCell

		let pet = petData[indexPath.row]
		cell!.updateWithPet(pet)
		
		return cell!
	}
}
