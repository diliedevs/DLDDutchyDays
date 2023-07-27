//
//  DDExclusions.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// A struct representing exclusions for certain dates.
///
/// `DDExclusions` conforms to the `OptionSet` protocol.
public struct DDExclusions: OptionSet {
    
    /// The underlying integer value of the option set.
    public let rawValue: Int
    
    /// Excludes weekends.
    public static let weekends = DDExclusions(rawValue: 1 << 0)
    
    /// Excludes Good Friday.
    public static let goodFriday = DDExclusions(rawValue: 1 << 1)
    
    /// Initializes a new instance of `DDExclusions` with the provided raw value.
    ///
    /// - Parameter rawValue: The raw value representing the exclusions.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
