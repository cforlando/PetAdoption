//
//  PFPetSizeType.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/9/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation

public enum PFPetSizeType: String, CustomStringConvertible
{
    case small = "S"
    case medium = "M"
    case large = "L"
    case xlarge = "XL"
    
    public var description: String
    {
        switch self
        {
            case .small: return "Small"
            case .medium: return "Medium"
            case .large: return "Large"
            case .xlarge: return "Extra Large"
        }
    }
}
