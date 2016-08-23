//
//  PTKPetShelter.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation
import MapKit

private let PTKShelterAddrCityKey = "shelterAddrCity"
private let PTKShelterAddrLine1Key = "shelterAddrLine1"
private let PTKShelterAddrLine2Key = "shelterAddrLine2"
private let PTKShelterAddrStKey = "shelterAddrSt"
private let PTKShelterAddrZipKey = "shelterAddrZip"
private let PTKShelterContactKey = "shelterContact"
private let PTKShelterEmailKey = "shelterEmail"
private let PTKShelterGeoLatKey = "shelterGeoLat"
private let PTKShelterGeoLonKey = "shelterGeoLon"
private let PTKShelterNameKey = "shelterName"
private let PTKShelterPhoneKey = "shelterPhone"
private let PTKShelterUrlKey = "shelterUrl"

public struct PTKPetShelter: Location {
    public let address1: String
    public let address2: String?
    public let city: String
    public let contact: String
    public let email: String
    public let locationCoordinates: CLLocationCoordinate2D?
    public let name: String
    public let phoneNumber: String
    public let state: String
    public let url: String
    public let zipcode: String
    
    init(json: [String: AnyObject]) {
        self.address1 = json[PTKShelterAddrLine1Key] as? String ?? ""
        self.address2 = json[PTKShelterAddrLine2Key] as? String
        self.city = json[PTKShelterAddrCityKey] as? String ?? ""
        self.contact = json[PTKShelterContactKey] as? String ?? ""
        self.email = json[PTKShelterEmailKey] as? String ?? ""
        self.name = json[PTKShelterNameKey] as? String ?? ""
        self.phoneNumber = json[PTKShelterPhoneKey] as? String ?? ""
        self.state = json[PTKShelterAddrStKey] as? String ?? ""
        self.url = json[PTKShelterUrlKey] as? String ?? ""
        self.zipcode = json[PTKShelterAddrZipKey] as? String ?? ""
        
        let latitudes = json[PTKShelterGeoLatKey] as? [CLLocationDegrees]
        let longitudes = json[PTKShelterGeoLonKey] as? [CLLocationDegrees]
        
        if let latitude = latitudes?.first, longitude = longitudes?.first {
            self.locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.locationCoordinates = nil
        }
        
    }
}