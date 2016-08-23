//
//  UIView+TopBorder.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/23/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

extension UIView
{
    public func addTopBorder(color color: UIColor = UIColor.blackColor(), thickness: CGFloat = 1.0)
    {
        let upperBorder = CALayer()
        upperBorder.backgroundColor = color.CGColor
        upperBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        self.layer.addSublayer(upperBorder)
    }
}