//
//  PTKSpecie.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation
import MapKit

//**********************************************************************************************************************
// MARK: - JSON Keys

private let PTKActivityLevelKey = "activityLevel"
private let PTKActQuicklyKey = "actQuickly"
private let PTKAdoptableKey = "adoptable"
private let PTKAgeKey = "age"
private let PTKCaseActiveKey = "caseActive"
private let PTKCaseNumberKey = "caseNumber"
private let PTKColorKey = "color"
private let PTKCrateTrainedKey = "crateTrained"
private let PTKCurrentShotsKey = "currentShots"
private let PTKDeclawedKey = "declawed"
private let PTKDescriptionKey = "description"
private let PTKGoodWithCatsKey = "goodWithCats"
private let PTKGoodWithDogsKey = "goodWithDogs"
private let PTKGoodWithKidsKey = "goodWithKids"
private let PTKHairLengthKey = "hairLength"
private let PTKHeartwormTestStatusKey = "worms"
private let PTKHouseTrainedKey = "houseTrained"
private let PTKImagesKey = "images"
private let PTKIntakeDateKey = "intakeDate"
private let PTKLostGeoLatKey = "lostGeoLat"
private let PTKLostGeoLonKey = "lostGeoLon"
private let PTKLostKey = "lost"
private let PTKPetIdKey = "petId"
private let PTKPetNameKey = "petName"
private let PTKPrimaryBreedKey = "primaryBreed"
private let PTKPurebredKey = "purebred"
private let PTKSecondaryBreedKey = "secondaryBreed"
private let PTKSexKey = "sex"
private let PTKSizeKey = "size"
private let PTKSpayedNeuteredKey = "spayedNeutered"
private let PTKSpecialNeedsKey = "specialNeeds"
private let PTKSpeciesKey = "species"

//**********************************************************************************************************************
// MARK: - Equatable Protocol

public func ==(lhs: PTKPet, rhs: PTKPet) -> Bool {
    return lhs.petId == rhs.petId
}

//**********************************************************************************************************************
// MARK: - Stuct Implementation

public struct PTKPet: SpecieDetails, Behavior, Medical, Location, CustomStringConvertible, Equatable {
    public let activityLevel: PTKActivityLevel
    public let age: PTKAgeRange
    public let color: String
    public let crateTrained: PTKCrateTrained
    public let declawed: PTKDeclawed
    public let description: String
    public let gender: PTKGender
    public let hairLength: String
    public let houseTrained: PTKHouseTrained
    public let imageURLPaths: [String]
    public let intakeDate: NSDate?
    public let isGoodWithCats: Bool
    public let isGoodWithDogs: Bool
    public let isGoodWithKids: Bool
    public let isPureBred: Bool
    public let isSpayed: Bool
    public let locationCoordinates: CLLocationCoordinate2D?
    public let microchip: PTKMicrochip
    public let name: String
    public let petId: String
    public let petShelter: PTKPetShelter
    public let primaryBreed: String
    public let secondaryBreed: String
    public let shots: PTKMedicalShotStatus
    public let size: String
    public let type: String
    public let worms: PTKHeartwormTestStatus
    
    init(json: [String: AnyObject]) {
        let activity = json[PTKActivityLevelKey] as? String ?? ""
        let age = json[PTKAgeKey] as? String ?? ""
        let crateTrainedString = json[PTKCrateTrainedKey] as? String ?? ""
        let currentShots = json[PTKCurrentShotsKey] as? String ?? ""
        let date = json[PTKIntakeDateKey] as? String ?? ""
        let declawed = json[PTKDeclawedKey] as? String ?? ""
        let gender = json[PTKSexKey] as? String ?? ""
        let houseTrainedString = json[PTKHouseTrainedKey] as? String ?? ""
        let latitudes = json[PTKLostGeoLatKey] as? [CLLocationDegrees]
        let longitudes = json[PTKLostGeoLonKey] as? [CLLocationDegrees]
        let wormStatus = json[PTKHeartwormTestStatusKey] as? String ?? "" // Until a test is available with this info, it will always be nil
        
        // property initialisation
        self.activityLevel = PTKActivityLevel(rawValue: activity) ?? .Unknown
        self.age = PTKAgeRange(string: age) ?? .Unknown
        self.color = json[PTKColorKey] as? String ?? "Unknown"
        self.crateTrained = PTKCrateTrained(rawValue: crateTrainedString) ?? .Unknown
        self.declawed = PTKDeclawed(rawValue: declawed) ?? .Unknown
        self.description = json[PTKDescriptionKey] as? String ?? "No description available"
        self.gender = PTKGender(rawValue: gender) ?? .Unknown
        self.hairLength = json[PTKHairLengthKey] as? String ?? ""
        self.houseTrained = PTKHouseTrained(rawValue: houseTrainedString) ?? .Unknown
        self.imageURLPaths = json[PTKImagesKey] as? [String] ?? []
        self.intakeDate = NSDateFormatter.ISO8601Formatter().dateFromString(date)
        self.isGoodWithCats = json[PTKGoodWithCatsKey] as? Bool ?? false
        self.isGoodWithDogs = json[PTKGoodWithDogsKey] as? Bool ?? false
        self.isGoodWithKids = json[PTKGoodWithKidsKey] as? Bool ?? false
        self.isPureBred = json[PTKPurebredKey] as? Bool ?? false
        self.isSpayed = json[PTKSpayedNeuteredKey] as? Bool ?? false
        self.microchip = PTKMicrochip(json: json)
        self.name = json[PTKPetNameKey] as? String ?? "No name"
        self.petId = json[PTKPetIdKey] as? String ?? "Unknown"
        self.petShelter = PTKPetShelter(json: json)
        self.primaryBreed = json[PTKPrimaryBreedKey] as? String ?? "Unknown"
        self.secondaryBreed = json[PTKSecondaryBreedKey] as? String ?? "Unknown"
        self.shots = PTKMedicalShotStatus(rawValue: currentShots) ?? .Unknown
        self.size = json[PTKSizeKey] as? String ?? "Unknown"
        self.type = json[PTKSpeciesKey] as? String ?? "Unknown"
        self.worms = PTKHeartwormTestStatus(string: wormStatus)
        
        if let latitude = latitudes?.first, longitude = longitudes?.first {
            self.locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.locationCoordinates = nil
        }
    }
}

