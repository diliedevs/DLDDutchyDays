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

extension Array where Element == DDHoliday {
    mutating func removeLiberation(withOccurrence occurrence: DDLiberationOccurrence, isQuinYear: Bool) {
        switch occurrence {
            case .always         : self.removeNone()
            case .never          : self.removeLiberationDay()
            case .everyFiveYears : isQuinYear ? self.removeNone() : self.removeLiberationDay()
        }
    }
    
    private mutating func removeLiberationDay() {
        self.removeAll(where: \.isLiberationDay)
    }
    
    private mutating func removeNone() {
        self.removeAll(where: { _ in return false })
    }
}
