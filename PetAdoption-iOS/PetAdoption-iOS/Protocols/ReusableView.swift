//
//  ReusableView.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/20/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView
{
    static var reuseIdentifier: String
    {
        return String(self)
    }
}