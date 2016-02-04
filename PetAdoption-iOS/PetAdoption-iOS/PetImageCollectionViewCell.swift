//
//  PetImageView.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import SDWebImage;

class PetImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet var petNameTextContainer: UIView!
	@IBOutlet var petImageView: UIImageView!
	@IBOutlet var petNameText: UILabel!
	
	func updateWithPet(pet: Pet) {
		self.petNameText.text = pet.petName;
		self.petImageView.sd_setImageWithURL(NSURL(string: pet.petImageUrls[0]), placeholderImage: UIImage(named: "Image Placeholder"));
		self.petImageView.contentMode = UIViewContentMode.ScaleAspectFill;
	}
	
}
