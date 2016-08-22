//
//  Location.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation
import MapKit

public protocol Location {
    var locationCoordinates: CLLocationCoordinate2D? { get }
}