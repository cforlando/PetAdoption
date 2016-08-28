//
//  NewPetListingDetailVC.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/25/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit

class NewPetListingDetailVC: UITableViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageContainerScrollView: UIScrollView!
    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var shelterNameLabel: UILabel!
    @IBOutlet weak var shelterAddress1Label: UILabel!
    @IBOutlet weak var shelterAddress2Label: UILabel!
    @IBOutlet weak var shelterCityStateZipLabel: UILabel!
    @IBOutlet weak var shelterPhoneNumberLabel: UILabel!
    @IBOutlet weak var shelterEmailLabel: UILabel!
    
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var pet: PTKPet!

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.themePrimaryColor()
        configureView()
    }

    ////////////////////////////////////////////////////////////

    override func viewDidLayoutSubviews()
    {
        self.imageContainerScrollView.delegate = self
        super.viewDidLayoutSubviews()
        self.displayImages()
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func configureView()
    {
        self.title = self.pet.name
        self.nameLabel.text = self.pet.name
        self.pageControl.numberOfPages = self.pet.imageURLPaths.count

        self.genderLabel.text = "Gender: \(self.pet.gender.rawValue)"
        self.ageLabel.text = "Age: \(self.pet.age.description)"
        self.sizeLabel.text = "Size: \(self.pet.size)"
        self.descriptionLabel.text = self.pet.description

        let shelter = self.pet.petShelter
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
        self.shelterCityStateZipLabel.text = "\(shelter.city), \(shelter.state) \(shelter.zipcode)"
        self.shelterPhoneNumberLabel.text = shelter.phoneNumber
        self.shelterEmailLabel.text = shelter.email
    }

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
    // MARK: - UITableViewDelegate
    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UIScrollViewDelegate
    ////////////////////////////////////////////////////////////

    override func scrollViewDidEndDecelerating(scrollView: UIScrollView)
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
