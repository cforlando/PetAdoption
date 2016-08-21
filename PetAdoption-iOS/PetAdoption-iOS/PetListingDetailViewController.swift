//
//  PetListingDetailsViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/13/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

class PetListingDetailViewController: UIViewController
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet var containerScrollView: UIScrollView!
    @IBOutlet var imageContainerScrollView: UIScrollView!
    @IBOutlet var detailsView: UIView!
    @IBOutlet var additionalDetailsTableView: UITableView!
    @IBOutlet var imageGalleryGradientView: UIView!

    @IBOutlet var imageContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var shadowView: UIView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    let cellIdentifier = "Cell"
    var pet : Pet!

    ////////////////////////////////////////////////////////////
    // MARK: - View Controller Life Cycle
    ////////////////////////////////////////////////////////////

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = pet.petName
        self.pageControl.numberOfPages = self.pet.petImageUrls.count
        self.titleLabel.text = self.pet.petName
        self.subTitleLabel.text = self.pet.petAttributeText
		
        self.shadowView.layer.shadowOpacity = 0.3
        self.shadowView.layer.shadowColor = UIColor.blackColor().CGColor
        self.shadowView.layer.shadowOffset = CGSizeMake(0, 0)
        self.shadowView.layer.shouldRasterize = true
		
        self.imageContainerScrollView.delegate = self
		
        self.additionalDetailsTableView.delegate = self
        self.additionalDetailsTableView.dataSource = self
		
        self.setBackgroundGradient()
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
		
        let fullWidth : CGFloat = CGFloat(self.pet.petImageUrls.count) * self.imageContainerScrollView.frame.width
		
        for (i, petImageUrl) in self.pet.petImageUrls.enumerate()
        {
            let xOffset = self.imageContainerScrollView.frame.width * CGFloat(i)
		
            let currentFrameOfScreen = CGRectMake(xOffset, 0, self.imageContainerScrollView.frame.width, self.imageContainerScrollView.frame.height)
            let petImageCell = UINib(nibName: ImageGalleryView.nibName, bundle: nil).instantiateWithOwner(self, options: nil)[0] as! ImageGalleryView
            petImageCell.frame = currentFrameOfScreen
            petImageCell.clipsToBounds = true
            petImageCell.updateWithPet(petImageUrl)
            self.imageContainerScrollView.addSubview(petImageCell)
        }
		
        self.imageContainerScrollView.contentSize = CGSizeMake(fullWidth, self.imageContainerScrollView.frame.height)
    }

    ////////////////////////////////////////////////////////////

    private func setBackgroundGradient()
    {
        self.imageGalleryGradientView.setNeedsLayout()
        self.imageGalleryGradientView.layoutIfNeeded()
        self.imageGalleryGradientView.backgroundColor = UIColor.clearColor()
		
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.imageGalleryGradientView.bounds
        gradient.colors = [UIColor(white: 0.5, alpha: 0).CGColor, UIColor.themePrimaryColor().CGColor]
        gradient.locations = [0.05, 1]
		
        self.imageGalleryGradientView.layer.insertSublayer(gradient, atIndex: 0)
    }
	
    ////////////////////////////////////////////////////////////
    // MARK: - UIScrollViewDelegate
    ////////////////////////////////////////////////////////////

    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if (scrollView == self.imageContainerScrollView)
        {
            let numberOfPages = self.pet.petImageUrls.count
            let fullContentWidth = scrollView.contentSize.width
            let widthOfIndividualItems = Int(fullContentWidth / CGFloat(numberOfPages))
			
            let offset = scrollView.contentOffset.x
            let page = Int(offset) / widthOfIndividualItems

            self.pageControl.currentPage = page
        }
    }
}

////////////////////////////////////////////////////////////

extension PetListingDetailViewController : UITableViewDelegate { }
extension PetListingDetailViewController : UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    ////////////////////////////////////////////////////////////
	
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.pet.petAttributes.count
    }

    ////////////////////////////////////////////////////////////
	
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        let data = self.pet.petAttributes[indexPath.row]
		
        cell!.textLabel?.text = data.attributeTitle
        cell!.textLabel?.backgroundColor = UIColor.clearColor()
        cell!.detailTextLabel?.text = data.attributeValue
        cell!.detailTextLabel?.backgroundColor = UIColor.clearColor()
		
        return cell!
    }
}
