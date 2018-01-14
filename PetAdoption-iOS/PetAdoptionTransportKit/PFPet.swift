//
//  PFPet.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/9/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PFPet
{
    public let name: String
    public let animalType: PFAnimalType
    public let age: PFPetAgeType
    public let sex: PFGender
    public let size: PFPetSizeType
    public let description: String
    public let status: String
    public let contact: PFContact
    public var breeds = [String]()
    public var isSpayed = false
    public var isHouseTrained = false
    public var isDeclawed = false
    public var isGoodWithKids = true
    public var isGoodWithDogs = true
    public var isGoodWithCats = true
    public var photos = [PFPhoto]()
    
    init(json: JSON)
    {
        self.name = json["name"]["$t"].string ?? ""
        self.animalType = PFAnimalType(rawValue: json["animal"]["$t"].stringValue)!
        self.age = PFPetAgeType(rawValue: json["age"]["$t"].stringValue)!
        self.sex = PFGender(rawValue: json["sex"]["$t"].stringValue)!
        self.size = PFPetSizeType(rawValue: json["size"]["$t"].stringValue)!
        self.description = json["description"]["$t"].string ?? ""
        self.status = json["status"]["$t"].string ?? ""
        self.contact = PFContact(json: json["contact"])
        
        // The JSON response for options comes back as either a single dictionary, if there is only one
        // option, or an array of dictionaries.  This check is required to ensure we are reading the
        // response correctly in either case.
        if let optionString = json["options"]["option"]["$t"].string
        {
            // TODO: Try to make a function for this since it's done in multiple places
            if let option = PFPetOptionType(rawValue: optionString)
            {
                switch option
                {
                    case .altered: self.isSpayed = true
                    case .housetrained, .housebroken: self.isHouseTrained = true
                    case .noClaws: self.isDeclawed = true
                    case .noKids: self.isGoodWithKids = false
                    case .noDogs: self.isGoodWithDogs = false
                    case .noCats: self.isGoodWithCats = false
                    default: print("")
                }
            }
        }
        else if let options = json["options"]["option"].array
        {
            for optionJson in options
            {
                if let optionString = optionJson["$t"].string
                {
                    if let option = PFPetOptionType(rawValue: optionString)
                    {
                        switch option
                        {
                            case .altered: self.isSpayed = true
                            case .housetrained, .housebroken: self.isHouseTrained = true
                            case .noClaws: self.isDeclawed = true
                            case .noKids: self.isGoodWithKids = false
                            case .noDogs: self.isGoodWithDogs = false
                            case .noCats: self.isGoodWithCats = false
                            default: print("")
                        }
                    }

                }
            }
        }
        
        // TODO: Try to make these checks part of a separate function, since we're doing it
        //       in more than one place
        if let breed = json["breeds"]["breed"]["$t"].string
        {
            self.breeds.append(breed)
        }
        else if let breeds = json["breed"]["breed"].array
        {
            for breedJson in breeds
            {
                if let breed = breedJson["$t"].string
                {
                    self.breeds.append(breed)
                }
            }
        }
        
        for jsonObject in json["media"]["photos"]["photo"]
        {
            let photo = PFPhoto(json: jsonObject.1)
            if photo.size == "x"
            {
                self.photos.append(photo)
            }
        }
    }
}
