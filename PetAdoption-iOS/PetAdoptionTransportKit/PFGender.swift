//
//  PFGender.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation

public enum PFGender: String, CustomStringConvertible
{
    case male = "M"
    case female = "F"
    
    public var description: String
    {
        switch self
        {
            case .male: return "Male"
            case .female: return "Female"
        }
    }
}
