//
//  PTKHeartwormTestStatus.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation

public enum PTKHeartwormTestStatus: String, CustomStringConvertible {
    case Unknown, No, TestedNegative, TestedPositive
    
    init(string: String) {
        switch string {
        case PTKHeartwormTestStatus.No.description:
            self = .No
        case PTKHeartwormTestStatus.TestedNegative.description:
            self = .TestedNegative
        case PTKHeartwormTestStatus.No.description:
            self = .TestedPositive
        default:
            self = .Unknown
        }
    }
    
    public var description: String {
        switch self {
        case .Unknown:
            return "Unknown"
        case .No:
            return "Not tested"
        case .TestedNegative:
            return "Tested Negative"
        case .TestedPositive:
            return "Tested Positive"
        }
    }
}
