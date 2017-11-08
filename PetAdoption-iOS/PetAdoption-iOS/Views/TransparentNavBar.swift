//
//  TransparentNavBar.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 3/3/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

@IBDesignable
class TransparentNavBar: UINavigationBar
{
    override func draw(_ rect: CGRect)
    {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true

        // Change the font and size of nav bar text
        if let navBarFont = UIFont(name: "OpenSans-Regular", size: 18.0)
        {
            let navBarAttributesDictionary: [NSAttributedStringKey: AnyObject]? =
            [
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: navBarFont
            ]

            self.titleTextAttributes = navBarAttributesDictionary
        }
    }

}
