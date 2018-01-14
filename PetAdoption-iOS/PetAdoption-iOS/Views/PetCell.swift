//
//  PetCell.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/19/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import Alamofire
import PetAdoptionTransportKit

public class PetCell: UICollectionViewCell, ReusableView
{
    ////////////////////////////////////////////////////////////
    // MARK: - IBOutlets
    ////////////////////////////////////////////////////////////

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var petNameLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    ////////////////////////////////////////////////////////////
    // MARK: - Properties
    ////////////////////////////////////////////////////////////

    private var request: Request?
    private var pet: PFPet?

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewReusableView
    ////////////////////////////////////////////////////////////

    override public func prepareForReuse()
    {
        super.prepareForReuse()
        self.imageView.image = UIImage(named: "placeholder")
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func configureCell(with pet: PFPet)
    {
        self.pet = pet
        self.petNameLabel.text = pet.name
        configureImage(frame: self.frame)
    }

    ////////////////////////////////////////////////////////////

    private func configureImage(frame: CGRect)
    {
        reset()
        loadImage(width: frame.width, height: frame.height)
    }

    ////////////////////////////////////////////////////////////

    private func reset()
    {
        self.imageView.image = UIImage(named: "placeholder")
        request?.cancel()
    }

    ////////////////////////////////////////////////////////////

    private func loadImage(width: CGFloat, height: CGFloat)
    {
        self.activityIndicator.startAnimating()

        if let imageUrl = self.pet?.photos.first?.url
        {
            self.request = PTKRequestManager.sharedInstance().request(imageAtPath: imageUrl)
            { image, error in
                self.populateCell(image: image)
            }
        }
    }

    ////////////////////////////////////////////////////////////

    private func populateCell(image: UIImage?)
    {
        self.activityIndicator.stopAnimating()
        if let image = image
        {
            self.imageView.image = image
        }
    }
}
