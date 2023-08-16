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
    
    /// Removes the Liberation Day event from the calendar with the specified occurrence.
    ///
    /// - Parameter occurrence: The occurrence of the Liberation Day event to be removed.
    mutating func removeLiberationDay(withOccurrence occurrence: DDLiberationOccurrence) {
        switch occurrence {
            case .always         : self.removeNone()
            case .never          : self.removeAllLiberation()
            case .everyFiveYears : self.removeQuinLiberation()
        }
    }
    
    private mutating func removeAllLiberation() {
        self.removeAll(where: \.isLiberationDay)
    }
    
    private mutating func removeQuinLiberation() {
        self.removeAll {
            $0.isLiberationDay && ($0.date.year.isFiveFold == false)
        }
    }
    
    private mutating func removeNone() {
        self.removeAll(where: { _ in return false })
    }
}
