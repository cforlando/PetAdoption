//
//  ImageGalleryView.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/14/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit

class ImageGalleryView: UIView
{
    @IBOutlet var imagePlacholderImageView: UIImageView!
    static let nibName = "ImageGalleryView"

    ////////////////////////////////////////////////////////////
	
    func updateWithPet(imageUrl: String)
    {
        _ = PTKRequestManager.sharedInstance().request(imageAtPath: imageUrl)
        { image, error in
            self.imagePlacholderImageView.image = image
        }
    }
}
