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
    case description
    case features
    case personality
    case adoptionInfo
}

////////////////////////////////////////////////////////////

struct SectionItem
{
    var name: String
    var value: String?
}

////////////////////////////////////////////////////////////

class PetListingDetailVC: UITableViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak var imageContainerScrollView: UIScrollView!
    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let estimatedRowHeight: CGFloat = 46.0
    var descriptionSection = [SectionItem]()
    var featuresSection = [SectionItem]()
    var personalitySection = [SectionItem]()
    var adoptionInfoSection = [SectionItem]()
    var dataSource = [[SectionItem]]()
    var images = [String]()

    var pet: PTKPet?
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
        self.pageControl.numberOfPages = self.pet?.imageURLPaths.count ?? 0
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
        guard let pet = self.pet else
        {
            return
        }

        self.title = pet.name

        self.descriptionSection =
        [
            SectionItem(name: "Description", value: pet.description)
        ]

        self.featuresSection =
        [
            SectionItem(name: "Breed", value: pet.primaryBreed),
            SectionItem(name: "Gender", value: pet.gender.rawValue),
            SectionItem(name: "Age", value: pet.age.description),
            SectionItem(name: "Weight", value: pet.size),
            SectionItem(name: "Spayed/Neutered", value: pet.isSpayed ? "Yes" : "No"),
            SectionItem(name: "Housebroken", value: pet.houseTrained.rawValue),
            SectionItem(name: "Declawed", value: pet.declawed.rawValue)
        ]

        self.personalitySection =
        [
            SectionItem(name: "Good with Kids", value: pet.isGoodWithKids ? "Yes" : "No"),
            SectionItem(name: "Good with Dogs", value: pet.isGoodWithDogs ? "Yes" : "No"),
            SectionItem(name: "Good with Cats", value: pet.isGoodWithCats ? "Yes" : "No")
        ]

        var intakeDateString = ""
        if let intakeDate = pet.intakeDate
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
            SectionItem(name: "Adoptable Since", value: intakeDateString)
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
        guard let pet = self.pet else
        {
            return
        }

        self.imageContainerScrollView.setNeedsLayout()
        self.imageContainerScrollView.layoutIfNeeded()

        self.imageContainerViewHeightConstraint.constant = self.imageContainerScrollView.frame.width * 0.6

        let fullWidth : CGFloat = CGFloat(pet.imageURLPaths.count ?? 0) * self.imageContainerScrollView.frame.width

        for (index, petImageUrl) in pet.imageURLPaths.enumerate()
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
            let numberOfPages = self.pet?.imageURLPaths.count ?? 0
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
        return self.estimatedRowHeight
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

        let item = self.dataSource[sectionNumber][rowNumber]

        switch (sectionNumber)
        {
            case Sections.description.rawValue:
                if let descriptionCell = tableView.dequeueReusableCellWithIdentifier(DescriptionCell.reuseIdentifier) as? DescriptionCell
                {
                    descriptionCell.descriptionLabel.text = item.value ?? ""
                    return descriptionCell
                }
            default:
                if let normalCell = tableView.dequeueReusableCellWithIdentifier("NormalCell")
                {
                    normalCell.textLabel?.text = item.name ?? ""
                    normalCell.detailTextLabel?.text = item.value ?? ""
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
