//
//  PFAnimalType.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/9/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation

public enum PFAnimalType: String, CustomStringConvertible
{
    case dog = "Dog"
    case cat = "Cat"
    case smallAndFurry = "Small&Furry"
    case barnyard = "BarnYard"
    case bird = "Bird"
    case horse = "Horse"
    case rabbit = "Rabbit"
    case reptile = "Reptile"

    public var description: String
    {
        switch self
        {
            case .dog: return "Dog"
            case .cat: return "Cat"
            case .smallAndFurry: return "Small & Furry"
            case .barnyard: return "Barnyard"
            case .bird: return "Bird"
            case .horse: return "Horse"
            case .rabbit: return "Rabbit"
            case .reptile: return "Reptile"
        }
    }
}
