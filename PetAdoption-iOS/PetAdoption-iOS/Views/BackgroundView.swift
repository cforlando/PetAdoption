//
//  BackgroundView.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 3/3/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView
{
    @IBInspectable var topColor: UIColor = UIColor(red: 0.17, green: 0.69, blue: 0.78, alpha: 1.0)
    @IBInspectable var bottomColor: UIColor = UIColor(red: 0.68, green: 0.78, blue: 0.25, alpha: 1.0)

    override func drawRect(rect: CGRect)
    {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()

        //// Gradient Declarations
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [topColor.CGColor, bottomColor.CGColor], [0, 1])

        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, gradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
        CGContextRestoreGState(context)
    }
}
