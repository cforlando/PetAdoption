//
//  HomeViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	@IBOutlet weak var collectionView: UICollectionView!
	
	var petData : [Pet] = [];
	let collectionViewCellId = "normal-cell";
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = NSLocalizedString("Home", comment: "");
		self.collectionView.delegate = self;
		self.collectionView.dataSource = self;
		self.collectionView.collectionViewLayout = CustomHomeCollectionViewFlowLayout();
		
		let normalCellView = UINib(nibName: "PetImageCollectionViewCell", bundle: nil);
		self.collectionView.registerNib(normalCellView, forCellWithReuseIdentifier: collectionViewCellId);
		
		//Load some data (fake data for now)
		let petService = FindPetsService();
		let result = petService.execute();
		self.petData = result.petsFound;
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
	// MARK: - UICollectionViewDataSource and Delegate
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1;
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.petData.count;
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
	
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellId, forIndexPath: indexPath) as? PetImageCollectionViewCell;
		let pet = petData[indexPath.row];
		cell!.updateWithPet(pet);
		
		return cell!;
	}
	
}
