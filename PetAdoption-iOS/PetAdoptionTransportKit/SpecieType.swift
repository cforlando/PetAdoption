//
//  SpecieType.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public protocol SpecieType {
    var type: String { get }
}

public protocol SpecieDetails: SpecieType {
    var isPureBred: Bool { get }
    var primaryBreed: String { get }
    var secondaryBreed: String { get }
}