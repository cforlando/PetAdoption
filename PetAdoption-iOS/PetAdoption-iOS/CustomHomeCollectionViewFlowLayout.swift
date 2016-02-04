//
//  CustomHomeCollectionViewFlowLayout.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class CustomHomeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	override init() {
		super.init()
		setupLayout()
	}
	
	override var itemSize: CGSize {
		set {
			
		}
		get {
			let numberOfColumns: CGFloat = 2;
			
			let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (numberOfColumns - 1)) / numberOfColumns
			return CGSizeMake(itemWidth, itemWidth)
		}
	}
 
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}
 
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
		scrollDirection = .Vertical
	}
}
