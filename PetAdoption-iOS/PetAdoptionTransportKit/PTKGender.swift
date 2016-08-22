//
//  PTKGender.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public enum PTKGender:String, CustomStringConvertible {
    case Unknown, Female, Male
    
    public var description: String {
        switch self {
        case .Female:
            return "Female"
        case .Male:
            return "Male"
        case .Unknown:
            return "Unknown"
        }
    }
}
