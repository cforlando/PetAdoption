//
//  PetListingDetailVC.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/25/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit

enum Sections: Int
{
    case description = 0
    case features = 1
    case personality = 2
    case adoptionInfo = 3
}

class PetListingDetailVC: UITableViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - Typealiases
    ////////////////////////////////////////////////////////////

    typealias DictOfOptionalStrings = Dictionary<String, String?>
    typealias ArrayofDicts = Array<DictOfOptionalStrings>

    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var imageContainerScrollView: UIScrollView!
    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    var descriptionSection = ArrayofDicts()
    var featuresSection = ArrayofDicts()
    var personalitySection = ArrayofDicts()
    var adoptionInfoSection = ArrayofDicts()
    var dataSource = [ArrayofDicts]()
    var images = [String]()

    var pet: PTKPet!
    {
        didSet
        {
            configureView()
        }
    }

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.pageControl.numberOfPages = self.pet.imageURLPaths.count
        self.tableView.backgroundColor = UIColor.themePrimaryColor()
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

        self.descriptionSection =
        [
            ["name" : "Description", "value" : self.pet.description]
        ]

        self.featuresSection =
        [
            ["name" : "Breed", "value" : self.pet.primaryBreed],
            ["name" : "Gender", "value" : self.pet.gender.rawValue],
            ["name" : "Age", "value" : self.pet.age.description],
            ["name" : "Weight", "value" : self.pet.size],
            ["name" : "Spayed/Neutered", "value" : self.pet.isSpayed ? "Yes" : "No"],
            ["name" : "Housebroken", "value" : self.pet.houseTrained.rawValue],
            ["name" : "Declawed", "value" : self.pet.declawed.rawValue]
        ]

        self.personalitySection =
        [
            ["name" : "Good with Kids", "value" : self.pet.isGoodWithKids ? "Yes" : "No"],
            ["name" : "Good with Dogs", "value" : self.pet.isGoodWithDogs ? "Yes" : "No"],
            ["name" : "Good with Cats", "value" : self.pet.isGoodWithCats ? "Yes" : "No"]
        ]

        var intakeDateString = ""
        if let intakeDate = self.pet.intakeDate
        {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            intakeDateString = formatter.stringFromDate(intakeDate)
        }
        else
        {
            intakeDateString = "Unknown"
        }

        self.adoptionInfoSection =
        [
            ["name" : "Adoptable Since", "value" : intakeDateString]
        ]

        self.dataSource =
        [
            self.descriptionSection,
            self.featuresSection,
            self.personalitySection,
            self.adoptionInfoSection
        ]
    }

    ////////////////////////////////////////////////////////////

    func displayImages()
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

    ////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 46.0
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    ////////////////////////////////////////////////////////////

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.dataSource.count
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case Sections.description.rawValue:
                return self.descriptionSection.count
            case Sections.features.rawValue:
                return self.featuresSection.count
            case Sections.personality.rawValue:
                return self.personalitySection.count
            case Sections.adoptionInfo.rawValue:
                return self.adoptionInfoSection.count
            default:
                return 0
        }
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let sectionNumber = indexPath.section
        let rowNumber = indexPath.row

        let dict = self.dataSource[sectionNumber][rowNumber]

        switch (sectionNumber)
        {
            case Sections.description.rawValue:
                if let descriptionCell = tableView.dequeueReusableCellWithIdentifier(DescriptionCell.reuseIdentifier) as? DescriptionCell
                {
                    descriptionCell.descriptionLabel.text = dict["value"] ?? ""
                    return descriptionCell
                }
            default:
                if let normalCell = tableView.dequeueReusableCellWithIdentifier("NormalCell")
                {
                    normalCell.textLabel?.text = dict["name"] ?? ""
                    normalCell.detailTextLabel?.text = dict["value"] ?? ""
                    return normalCell
                }
        }

        return UITableViewCell()
    }

    ////////////////////////////////////////////////////////////

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch (section)
        {
            case Sections.description.rawValue:
                return nil
            case Sections.features.rawValue:
                return "Features"
            case Sections.personality.rawValue:
                return "Personality"
            case Sections.adoptionInfo.rawValue:
                return "Adoption Information"
            default:
                return nil
        }
    }
}
