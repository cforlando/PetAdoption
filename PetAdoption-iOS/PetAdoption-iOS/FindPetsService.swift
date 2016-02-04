//
//  FindPetsService.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/2/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class FindPetsService: NSObject {

	func execute() -> FindPetsResult {
		let result = FindPetsResult();
		let fakePetImages = [
			"http://a.dilcdn.com/bl/wp-content/uploads/sites/8/2012/09/02-11.jpg",
			"https://pbs.twimg.com/profile_images/378800000532546226/dbe5f0727b69487016ffd67a6689e75a.jpeg",
			"http://dailytekkcom.c.presscdn.com/wp-content/uploads/2015/07/Grumpy_Cat_Endorsement-017d7-ULFU.jpg",
			"https://s-media-cache-ak0.pinimg.com/originals/5b/f0/7e/5bf07e12df991f3c01d73110b131a5fa.jpg"
		];
		
		var fakePetImageIndex = 0;
		for (var i = 0; i < 10; i++) {
			let pet = Pet();
			pet.petName = "Marco \(i)";
			pet.petImageUrls = [
				fakePetImages[fakePetImageIndex]
			];
			
			fakePetImageIndex++;
			
			if (fakePetImageIndex >= fakePetImages.count)
			{
				fakePetImageIndex = 0;
			}
			
			result.petsFound.append(pet);
		}
		
		return result;
	}
	
}
