//
//  PTKAgeRange.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public enum PTKAgeRange: CustomStringConvertible {
    case Unknown, Elderly, Senior, MiddleAge, Mature, Young, Baby, NewBorn
    
    init(string: String) {
        switch string {
        case PTKAgeRange.NewBorn.description:
            self = .NewBorn
        case PTKAgeRange.Baby.description:
            self = .Baby
        case PTKAgeRange.Young.description:
            self = .Young
        case PTKAgeRange.Mature.description:
            self = .Mature
        case PTKAgeRange.MiddleAge.description:
            self = .MiddleAge
        case PTKAgeRange.Senior.description:
            self = .Senior
        case PTKAgeRange.Elderly.description:
            self = .Elderly
        default:
            self = .Unknown
        }
    }
    
    public var description: String {
        switch self {
        case .Elderly:
            return "10+ years"
        case .Senior:
            return "7-10 years"
        case .MiddleAge:
            return "4-7 years"
        case .Mature:
            return "2-4 years"
        case .Young:
            return "1-2 years"
        case .Baby:
            return "6-12 months"
        case .NewBorn:
            return "0-6 months"
        case .Unknown:
            return "Unknown"
        }
    }
}
