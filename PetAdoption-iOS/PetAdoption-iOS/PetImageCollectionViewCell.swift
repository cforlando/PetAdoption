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
	static let DID_TAP_ON_PET_CELL_NOTIFICATION = "DID_TAP_ON_PET_CELL_NOTIFICATION";
	
	@IBOutlet var petNameTextContainer: UIView!
	@IBOutlet var petImageView: UIImageView!
	@IBOutlet var petNameText: UILabel!
	@IBOutlet var petNameAttributeSubLabel: UILabel!
	
	@IBOutlet var shadowView: UIView!
	
	private var didDoInitialSetup = false;
	
	var pet : Pet!;
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
	
	func updateWithPet(pet: Pet) {
		self.pet = pet;
		self.petNameText.text = pet.petName;
		self.petNameAttributeSubLabel.text = pet.petAttributeText;
		self.petImageView.sd_setImageWithURL(NSURL(string: pet.petImageUrls[0]), placeholderImage: UIImage(named: "placeholder"));
		self.petImageView.contentMode = UIViewContentMode.ScaleAspectFill;
		
		if (!didDoInitialSetup) {
			self.layer.borderWidth = 0.25;
			self.layer.borderColor = UIColor(white: 0.7, alpha: 1).CGColor;
			didDoInitialSetup = true;
			let imageTapGesture = UITapGestureRecognizer(target: self, action:#selector(PetImageCollectionViewCell.didTap));
			let labelTapGesture = UITapGestureRecognizer(target: self, action:#selector(PetImageCollectionViewCell.didTap));
			self.petImageView.addGestureRecognizer(imageTapGesture);
			self.petNameTextContainer.addGestureRecognizer(labelTapGesture);
			self.setBackgroundGradient();
			self.setShadowToCell();
		}
	}
	
	private func setBackgroundGradient() {
		self.setNeedsLayout();
		self.layoutIfNeeded();
		self.petNameTextContainer.setNeedsLayout();
		self.petNameTextContainer.layoutIfNeeded();
		self.petNameTextContainer.backgroundColor = UIColor.clearColor();
		
		let gradient: CAGradientLayer = CAGradientLayer();
		gradient.frame = self.petNameTextContainer.bounds;
		gradient.colors = [UIColor(white: 0.3, alpha: 0).CGColor, UIColor.themePrimaryColor().CGColor];
		gradient.locations = [0.05, 1];
		
		self.petNameTextContainer.layer.insertSublayer(gradient, atIndex: 0);
	}
	
	private func setShadowToCell() {
		self.shadowView.backgroundColor = UIColor(white: 1, alpha: 1);
		self.shadowView.layer.shadowOpacity = 0.2;
		self.shadowView.layer.shadowColor = UIColor.blackColor().CGColor;
		self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
		self.shadowView.layer.shouldRasterize = true;
	}
	
	@objc
	private func didTap() {
		UIView.animateWithDuration(0.1, animations: { () -> Void in
			self.petImageView.alpha = 0.5;
			
			}) { (complete) -> Void in
				NSNotificationCenter.defaultCenter().postNotificationName(PetImageCollectionViewCell.DID_TAP_ON_PET_CELL_NOTIFICATION, object: self.pet);
				
				if (complete) {
					self.petImageView.alpha = 1;
					UIView.animateWithDuration(0.2, animations: { () -> Void in
						
					});
				}
		};
	}
	
}
