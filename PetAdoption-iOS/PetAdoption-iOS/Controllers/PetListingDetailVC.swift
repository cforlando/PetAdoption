//
//  PetListingDetailVC.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/25/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit

class PetListingDetailVC: UITableViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    // Image View
    @IBOutlet weak var imageContainerScrollView: UIScrollView!
    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    // Description
    @IBOutlet weak var descriptionLabel: UILabel!

    // Features
    @IBOutlet weak var primaryBreedLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var neuteredLabel: UILabel!
    @IBOutlet weak var housebrokenLabel: UILabel!
    @IBOutlet weak var declawedLabel: UILabel!

    // Personality
    @IBOutlet weak var goodWithKidsLabel: UILabel!
    @IBOutlet weak var goodWithDogsLabel: UILabel!
    @IBOutlet weak var goodWithCatsLabel: UILabel!

    // Adoption Info
    @IBOutlet weak var intakeDateLabel: UILabel!
    
    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var descriptionSection = [String : String?]()
    var featuresSection = [String : String?]()
    var personalitySection = [String : String?]()
    var adoptionInfoSection = [String : String?]()
    var pet: PTKPet!
    {
        didSet
        {
            descriptionSection["Description"] = pet.description

            featuresSection["Breed"] = pet.primaryBreed
            featuresSection["Gender"] = pet.gender.rawValue
            featuresSection["Age"] = pet.age.description
            featuresSection["Weight"] = pet.size
            featuresSection["Neutered"] = pet.isSpayed ? "Yes" : "No"
            featuresSection["Housebroken"] = pet.houseTrained.rawValue
            featuresSection["Declawed"] = pet.declawed.rawValue

            personalitySection["Good with Kids"] = pet.isGoodWithKids ? "Yes" : "No"
            personalitySection["Good with Dogs"] = pet.isGoodWithDogs ? "Yes" : "No"
            personalitySection["Good with Cats"] = pet.isGoodWithCats ? "Yes" : "No"

            if let intakeDate = self.pet.intakeDate
            {
                let formatter = NSDateFormatter()
                formatter.dateStyle = .LongStyle
                adoptionInfoSection["Adoptable Since"] = formatter.stringFromDate(intakeDate)
            }
            else
            {
                adoptionInfoSection["Adoptable Since"] = "Unknown"
            }

        }
    }

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
        self.pageControl.numberOfPages = self.pet.imageURLPaths.count
        self.descriptionLabel.text = self.pet.description

        self.primaryBreedLabel.text = self.pet.primaryBreed
        self.genderLabel.text = self.pet.gender.rawValue
        self.ageLabel.text = self.pet.age.description
        self.sizeLabel.text = self.pet.size
        self.neuteredLabel.text = self.pet.isSpayed ? "Yes" : "No"
        self.housebrokenLabel.text = self.pet.houseTrained.rawValue
        self.declawedLabel.text = self.pet.declawed.rawValue

        self.goodWithKidsLabel.text = self.pet.isGoodWithKids ? "Yes" : "No"
        self.goodWithDogsLabel.text = self.pet.isGoodWithDogs ? "Yes" : "No"
        self.goodWithCatsLabel.text = self.pet.isGoodWithCats ? "Yes" : "No"

        if let intakeDate = self.pet.intakeDate
        {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            self.intakeDateLabel.text = formatter.stringFromDate(intakeDate)
        }
        else
        {
            self.intakeDateLabel.text = "Unknown"
        }

        print(featuresSection)
        print(personalitySection)
        print(adoptionInfoSection)
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
