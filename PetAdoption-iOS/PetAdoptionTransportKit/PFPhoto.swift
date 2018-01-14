//
//  PFPhoto.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PFPhoto
{
    public let id: String
    public let size: String
    public let url: String
    
    init(json: JSON)
    {
        self.id = json["@id"].stringValue
        self.size = json["@size"].stringValue
        self.url = json["$t"].stringValue
    }
}
