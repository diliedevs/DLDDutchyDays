//
//  DDHoliday.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// A struct representing a holiday.
///
/// `DDHoliday` conforms to the `Codable` and `Identifiable` protocols.
public struct DDHoliday: Codable, Identifiable {
    
    /// The date of the holiday.
    public let date: Date
    
    /// The name of the holiday.
    public let name: String
    
    /// The local name of the holiday.
    public let localName: String
    
    /// The unique identifier of the holiday based on its date.
    public var id: Double { date.timeIntervalSinceReferenceDate }
    
    /// Indicates whether the holiday falls on a weekend.
    public var isInWeekend: Bool { date.isWeekend }
    
    /// Indicates whether the holiday is Good Friday.
    public var isGoodFriday: Bool { lowName.hasPrefix("good") }
    
    /// Indicates whether the holiday is Liberation Day.
    public var isLiberationDay: Bool { lowName.hasPrefix("liberation") }
    
    /// Initializes a new instance of `DDHoliday` with the provided information.
    ///
    /// - Parameters:
    ///   - date: The date of the holiday.
    ///   - name: The name of the holiday.
    ///   - localName: The local name of the holiday.
    public init(date: Date, name: String, localName: String) {
        self.date = date
        self.name = name
        self.localName = localName
    }
}

private extension DDHoliday {
    var lowName: String { name.lowercased() }
}

extension Array where Element == DDHoliday {
    mutating func removeWeekends() {
        self.removeAll(where: \.isInWeekend)
    }
    
    mutating func removeGoodFriday() {
        self.removeAll(where: \.isGoodFriday)
    }
}
