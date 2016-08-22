//
//  PTKMicrochip.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

private let PTKMicrochipKey = "microchip"
private let PTKMicrochipNumberKey = "microchip_number"

public struct PTKMicrochip {
    public let status: PTKMicrochipStatus
    public let identifier: String?
    
    init(json: [String: AnyObject]) {
        let microchipStatus = json[PTKMicrochipKey] as? String ?? ""
        
        self.status = PTKMicrochipStatus(rawValue: microchipStatus) ?? .Unknown
        self.identifier = json[PTKMicrochipNumberKey] as? String
    }
}