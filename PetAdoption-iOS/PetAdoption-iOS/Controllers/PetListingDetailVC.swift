//
//  PetListingDetailVC.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/25/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import PetAdoptionTransportKit
import MessageUI
import Foundation

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

class PetListingDetailVC: UITableViewController, MFMailComposeViewControllerDelegate
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

    var pet: PFPet?
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
        self.pageControl.numberOfPages = self.pet?.photos.count ?? 0
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
            SectionItem(name: "Breed", value: pet.breeds.first ?? "unknown"),
            SectionItem(name: "Gender", value: pet.sex.description),
            SectionItem(name: "Age", value: pet.age.rawValue),
            SectionItem(name: "Size", value: pet.size.description),
            SectionItem(name: "Spayed/Neutered", value: pet.isSpayed ? "Yes" : "No"),
            SectionItem(name: "Housebroken", value: pet.isHouseTrained ? "Yes" : "No"),
            SectionItem(name: "Declawed", value: pet.isDeclawed ? "Yes" : "No")
        ]

        self.personalitySection =
        [
            SectionItem(name: "Good with Kids", value: pet.isGoodWithKids ? "Yes" : "No"),
            SectionItem(name: "Good with Dogs", value: pet.isGoodWithDogs ? "Yes" : "No"),
            SectionItem(name: "Good with Cats", value: pet.isGoodWithCats ? "Yes" : "No")
        ]

//        var intakeDateString = ""
//        if let intakeDate = pet.intakeDate
//        {
//            let formatter = DateFormatter()
//            formatter.dateStyle = .long
//            intakeDateString = formatter.string(from: intakeDate)
//        }
//        else
//        {
//            intakeDateString = "Unknown"
//        }
//
        
        self.adoptionInfoSection =
        [
            SectionItem(name: "Phone Number", value: pet.contact.phone),
            SectionItem(name: "E-mail", value: pet.contact.email)
//            SectionItem(name: "Adoptable Since", value: intakeDateString)
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

        let fullWidth : CGFloat = CGFloat(pet.photos.count) * self.imageContainerScrollView.frame.width

        for (index, petImageUrl) in pet.photos.enumerated()
        {
            let xOffset = self.imageContainerScrollView.frame.width * CGFloat(index)

            let currentFrameOfScreen = CGRect(x: xOffset, y: 0, width: self.imageContainerScrollView.frame.width, height: self.imageContainerScrollView.frame.height)
            if let petImageCell = UINib(nibName: ImageGalleryView.nibName, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ImageGalleryView
            {
                petImageCell.frame = currentFrameOfScreen
                petImageCell.clipsToBounds = true
                petImageCell.updateWithPet(imageUrl: petImageUrl.url)
                self.imageContainerScrollView.addSubview(petImageCell)
            }
        }

        self.imageContainerScrollView.contentSize = CGSize(width: fullWidth, height: self.imageContainerScrollView.frame.height)
    }
    
    ////////////////////////////////////////////////////////////
    // MARK: - Email Logic
    ////////////////////////////////////////////////////////////
    
    func configureMailController() -> MFMailComposeViewController? {
        guard let pet = pet, pet.contact.email != "" else { return nil }
        let mailComposerVC = MFMailComposeViewController()
            let emailString = pet.contact.email
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([emailString])
            mailComposerVC.setSubject("Adoption!")
            mailComposerVC.setMessageBody("Hello! I'm interested in giving this pet a new home!", isHTML: false)
            return mailComposerVC
    }

    
    func displayEmailError() {
        let sendEmailErrorAlert = UIAlertController(title: "Could not send email", message: nil, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendEmailErrorAlert.addAction(dismiss)
        self.present(sendEmailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    ////////////////////////////////////////////////////////////
    // MARK: - Phone Logic
    ////////////////////////////////////////////////////////////
    
//    func callCellPushed(sender: AnyObject) {
//        if let url = URL(string: "tel://\(pet?.contact.phone)") {
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                print("Unable to send call.")
//            }
//        }
//    }
//

    ////////////////////////////////////////////////////////////
    // MARK: - UIScrollViewDelegate
    ////////////////////////////////////////////////////////////

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if (scrollView == self.imageContainerScrollView)
        {
            let numberOfPages = self.pet?.photos.count ?? 0
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

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.estimatedRowHeight
    }

    ////////////////////////////////////////////////////////////

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    ////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    ////////////////////////////////////////////////////////////

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.dataSource.count
    }

    ////////////////////////////////////////////////////////////

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let sectionNumber = indexPath.section
        let rowNumber = indexPath.row

        let item = self.dataSource[sectionNumber][rowNumber]

        switch (sectionNumber)
        {
            case Sections.description.rawValue:
                if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseIdentifier) as? DescriptionCell
                {
                    descriptionCell.descriptionLabel.text = item.value ?? ""
                    return descriptionCell
                }
            default:
                if let normalCell = tableView.dequeueReusableCell(withIdentifier: "NormalCell")
                {
                    normalCell.textLabel?.text = item.name 
                    normalCell.detailTextLabel?.text = item.value ?? ""
                    return normalCell
                }
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sectionNumber = indexPath.section
        let rowNumber = indexPath.row
        
        if sectionNumber == 3 && rowNumber == 1 {
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail() {
                self.present((mailComposeViewController)!, animated: true, completion: nil)
            } else {
                displayEmailError()
            }
        }

//        If the return type for configureMailController() is optional like I suggested above,
//        you can wrap all of this code in an if let and only try to
//        present the controller if there is actually an email address.
//

}

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
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
                return "Contact Information"
            default:
                return nil
        }
    }

}
