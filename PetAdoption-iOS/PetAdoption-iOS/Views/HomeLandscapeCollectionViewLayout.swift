//
//  HomeLandscapeCollectionViewLayout.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 9/10/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class HomeLandscapeCollectionViewLayout: UICollectionViewFlowLayout
{
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    override var itemSize: CGSize
        {
        set
        {

        }

        get
        {
            let itemWidth = CGRectGetWidth(self.collectionView!.frame) / 3.0;
            return CGSizeMake(itemWidth, itemWidth);
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Initializers
    ////////////////////////////////////////////////////////////

    override init()
    {
        super.init()
        setupLayout()
    }

    ////////////////////////////////////////////////////////////

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupLayout()
    }

    ////////////////////////////////////////////////////////////

    func setupLayout()
    {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Vertical
    }
}
