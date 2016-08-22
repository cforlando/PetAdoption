//
//  Medical.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public protocol Medical {
    var age: PTKAgeRange { get }
    var declawed: PTKDeclawed { get }
    var gender: PTKGender { get }
    var microchip: PTKMicrochip { get }
    var shots: PTKMedicalShotStatus { get }
    var isSpayed: Bool { get }
    var worms: PTKHeartwormTestStatus { get }
}
