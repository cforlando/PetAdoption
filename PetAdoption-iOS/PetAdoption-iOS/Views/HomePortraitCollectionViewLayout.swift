//
//  HomePortraitCollectionViewLayout.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class HomePortraitCollectionViewLayout: UICollectionViewFlowLayout
{
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    override var itemSize: CGSize
    {
        set { }
        get
        {
            let itemWidth = CGRectGetWidth(self.collectionView!.frame) / 2.0;
            return CGSizeMake(itemWidth, itemWidth);
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Initializers
    ////////////////////////////////////////////////////////////

	override init()
    {
		super.init()
		self.setupLayout()
	}

    ////////////////////////////////////////////////////////////

	required init?(coder aDecoder: NSCoder)
    {
		super.init(coder: aDecoder)
		self.setupLayout()
	}

    ////////////////////////////////////////////////////////////
 
	func setupLayout()
    {
		self.minimumInteritemSpacing = 0
		self.minimumLineSpacing = 0
		self.scrollDirection = .Vertical
	}
}
