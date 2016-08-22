//
//  Behavior.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public protocol Behaviour {
    var activityLevel: PTKActivityLevel { get }
    var crateTrained: PTKCrateTrained { get }
    var isGoodWithCats: Bool { get }
    var isGoodWithDogs: Bool { get }
    var isGoodWithKids: Bool { get }
    var houseTrained: PTKHouseTrained { get }
}
