//
//  DDExclusions.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// <#Description#>
public struct DDExclusions: OptionSet {
    /// <#Description#>
    public let rawValue: Int
    
    /// <#Description#>
    public static let weekends = DDExclusions(rawValue: 1 << 0)
    /// <#Description#>
    public static let goodFriday = DDExclusions(rawValue: 1 << 1)
    
    /// <#Description#>
    /// - Parameter rawValue: <#rawValue description#>
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
