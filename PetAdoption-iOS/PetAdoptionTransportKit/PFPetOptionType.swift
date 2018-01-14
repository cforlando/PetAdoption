//
//  PFPetOptionType.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/9/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation

public enum PFPetOptionType: String, CustomStringConvertible
{
    case specialNeeds = "specialNeeds"
    case noDogs = "noDogs"
    case noCats = "noCats"
    case noKids = "noKids"
    case noClaws = "noClaws"
    case hasShots = "hasShots"
    case housebroken = "housebroken"
    case housetrained = "housetrained"
    case altered = "altered"
    case unknown
    
    public var description: String
    {
        switch self
        {
            case .specialNeeds: return "Special Needs"
            case .noDogs: return "No Dogs"
            case .noCats: return "No Cats"
            case .noKids: return "No Kids"
            case .noClaws: return "No Claws"
            case .hasShots: return "Has Shots"
            case .housebroken: return "Housebroken"
            case .housetrained: return "House-trained"
            case .altered: return "Altered"
            case .unknown: return ""
        }
    }
}
