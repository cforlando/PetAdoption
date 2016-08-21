//
//  PetCell.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/19/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import Alamofire

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
    private var pet: Pet?

    ////////////////////////////////////////////////////////////
    // MARK: - UICollectionViewReusableView
    ////////////////////////////////////////////////////////////

    override public func prepareForReuse()
    {
        super.prepareForReuse()
        imageView.image = UIImage(named: "placeholder")
    }

    ////////////////////////////////////////////////////////////
    // MARK: - Helper Functions
    ////////////////////////////////////////////////////////////

    func configureCell(with pet: Pet)
    {
        self.pet = pet
        petNameLabel.text = pet.petName
        configureImage(self.frame)
    }

    ////////////////////////////////////////////////////////////

    private func configureImage(frame: CGRect)
    {
        reset()
        loadImage(frame.width, height: frame.height)
    }

    ////////////////////////////////////////////////////////////

    private func reset()
    {
        imageView.image = UIImage(named: "placeholder")
        request?.cancel()
    }

    ////////////////////////////////////////////////////////////

    private func loadImage(width: CGFloat, height: CGFloat)
    {
        activityIndicator.startAnimating()

        if let imageUrl = self.pet?.petImageUrls[0]
        {
            request = UIImage.getImage(from: imageUrl)
            { image in
                self.populateCell(image)
            }
        }
        else
        {
            request = UIImage.getPlaceholderImage(width: Int(width), height: Int(height))
            { image in
                self.populateCell(image)
            }
        }
    }

    ////////////////////////////////////////////////////////////

    private func populateCell(image: UIImage?)
    {
        activityIndicator.stopAnimating()
        if let image = image
        {
            imageView.image = image
        }
    }
}
