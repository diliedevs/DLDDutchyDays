//
//  DDLiberationOccurrence.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// An enumeration representing the occurrence of Liberation Day.
///
/// `DDLiberationOccurrence` conforms to the `String`, `CaseIterable`, and `Identifiable` protocols.
public enum DDLiberationOccurrence: String, CaseIterable, Identifiable {
    
    /// Liberation Day always occurs.
    case always
    
    /// Liberation Day never occurs.
    case never
    
    /// Liberation Day occurs every five years.
    case everyFiveYears
    
    /// The unique identifier of the occurrence.
    public var id: String { rawValue }
    
    /// The title of the occurrence.
    public var title: String {
        self == .everyFiveYears ? "Every 5 years" : rawValue.capitalized
    }
}

/// An extension for `Array` with `Element` constrained to `DDHoliday`.
public extension Array where Element == DDHoliday {
    
    /// Removes the Liberation Day from the array based on the specified `occurrence` and `isQuinYear` flag.
    ///
    /// - Parameters:
    ///   - occurrence: The occurrence of Liberation Day.
    ///   - isQuinYear: A boolean flag indicating if the year is a multiple of 5.
    mutating func removeLiberationDay(withOccurrence occurrence: DDLiberationOccurrence, isQuinYear: Bool) {
        switch occurrence {
            case .always         : self.removeNone()
            case .never          : self.removeLiberation()
            case .everyFiveYears : isQuinYear ? self.removeNone() : self.removeLiberation()
        }
    }
    
    /// Removes the `LiberationDay` from the array.
    private mutating func removeLiberation() {
        self.removeAll(where: \.isLiberationDay)
    }
    
    /// Removes all elements from the array.
    private mutating func removeNone() {
        self.removeAll(where: { _ in return false })
    }
}
