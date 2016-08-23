//
//  PetListingDetailsViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/13/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit

class PetListingDetailViewController: UIViewController, UIScrollViewDelegate
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var imageContainerScrollView: UIScrollView!
    @IBOutlet var imageGalleryGradientView: UIView!

    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var titleLabel: UILabel!

    @IBOutlet weak var generalInfoView: UIView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var contactInfoView: UIView!
    @IBOutlet weak var shelterNameLabel: UILabel!
    @IBOutlet weak var shelterAddress1Label: UILabel!
    @IBOutlet weak var shelterAddress2Label: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let cellIdentifier = "Cell"
    var pet : PTKPet!

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        // TODO: The Call, Email, and Website controls under the images will still need to be implemented.
        
        super.viewDidLoad()
        self.title = self.pet.name
        self.pageControl.numberOfPages = self.pet.imageURLPaths.count
        self.titleLabel.text = self.pet.name

        let shelter = self.pet.petShelter

        self.generalInfoView.addTopBorder()
        self.genderLabel.text = self.pet.gender.rawValue
        self.sizeLabel.text = self.pet.size
        self.ageLabel.text = self.pet.age.description
        self.locationLabel.text = shelter.name == "" ? "N/A" : shelter.name

        self.descriptionView.addTopBorder()
        self.descriptionLabel.text = self.pet.description

        self.contactInfoView.addTopBorder()
        self.shelterNameLabel.text = shelter.name
        self.shelterAddress1Label.text = shelter.address1
        if let address2 = shelter.address2
        {
            self.shelterAddress2Label.hidden = false
            self.shelterAddress2Label.text = address2
        }
        else
        {
            self.shelterAddress2Label.hidden = true
        }

        let isCityStateZipBlank = (shelter.city == "") || (shelter.state == "") || (shelter.zipcode == "")
        self.cityStateZipLabel.text = isCityStateZipBlank ? "" : "\(shelter.city) \(shelter.state), \(shelter.zipcode)"
        self.phoneLabel.text = shelter.phoneNumber
        self.emailAddressLabel.text = shelter.email
		
        self.imageContainerScrollView.delegate = self
    }

    ////////////////////////////////////////////////////////////

    override func viewDidLayoutSubviews()
    {
        self.displayImages()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    private func displayImages()
    {
        self.imageContainerScrollView.setNeedsLayout()
        self.imageContainerScrollView.layoutIfNeeded()
		
        self.imageContainerViewHeightConstraint.constant = self.imageContainerScrollView.frame.width * 0.6
		
        let fullWidth : CGFloat = CGFloat(self.pet.imageURLPaths.count) * self.imageContainerScrollView.frame.width
		
        for (index, petImageUrl) in self.pet.imageURLPaths.enumerate()
        {
            let xOffset = self.imageContainerScrollView.frame.width * CGFloat(index)
		
            let currentFrameOfScreen = CGRectMake(xOffset, 0, self.imageContainerScrollView.frame.width, self.imageContainerScrollView.frame.height)
            if let petImageCell = UINib(nibName: ImageGalleryView.nibName, bundle: nil).instantiateWithOwner(self, options: nil)[0] as? ImageGalleryView
            {
                petImageCell.frame = currentFrameOfScreen
                petImageCell.clipsToBounds = true
                petImageCell.updateWithPet(petImageUrl)
                self.imageContainerScrollView.addSubview(petImageCell)
            }
        }
		
        self.imageContainerScrollView.contentSize = CGSizeMake(fullWidth, self.imageContainerScrollView.frame.height)
    }
	
    ////////////////////////////////////////////////////////////
    // MARK: - UIScrollViewDelegate
    ////////////////////////////////////////////////////////////

    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if (scrollView == self.imageContainerScrollView)
        {
            let numberOfPages = self.pet.imageURLPaths.count
            let fullContentWidth = scrollView.contentSize.width
            let widthOfIndividualItems = Int(fullContentWidth / CGFloat(numberOfPages))
			
            let offset = scrollView.contentOffset.x
            let page = Int(offset) / widthOfIndividualItems

            self.pageControl.currentPage = page
        }
    }
}
