//
//  DDLiberationOccurrence.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// <#Description#>
public enum DDLiberationOccurrence: String, CaseIterable, Identifiable {
    case always, never, everyFiveYears
    
    /// <#Description#>
    public var id: String { rawValue }
    /// <#Description#>
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
