//
//  ImageGalleryView.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/14/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class ImageGalleryView: UIView
{
    @IBOutlet var imagePlacholderImageView: UIImageView!
    static let nibName = "ImageGalleryView"

    ////////////////////////////////////////////////////////////
	
    func updateWithPet(imageUrl: String)
    {
        let url = NSURL(string: imageUrl)
        self.imagePlacholderImageView.sd_setImageWithURL(url)
    }
}
