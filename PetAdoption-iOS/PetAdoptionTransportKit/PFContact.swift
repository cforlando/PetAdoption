//
//  PFContact.swift
//  PetAdoptionTransportKit
//
//  Created by Kelii Martin on 1/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PFContact
{
    public let name: String
    public let address1: String
    public let address2: String
    public let state: String
    public let zip: String
    public let phone: String
    public let fax: String
    public let email: String
    
    init(json: JSON)
    {
        self.name = json["name"]["$t"].string ?? ""
        self.address1 = json["address1"]["$t"].string ?? ""
        self.address2 = json["address2"]["$t"].string ?? ""
        self.state = json["state"]["$t"].string ?? ""
        self.zip = json["zip"]["$t"].string ?? ""
        self.phone = json["phone"]["$t"].string ?? ""
        self.fax = json["fax"]["$t"].string ?? ""
        self.email = json["email"]["$t"].string ?? ""
    }
}
