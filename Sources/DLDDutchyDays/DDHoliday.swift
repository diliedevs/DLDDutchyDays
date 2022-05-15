//
//  DDHoliday.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// <#Description#>
public struct DDHoliday: Codable, Identifiable {
    /// <#Description#>
    public let date      : Date
    /// <#Description#>
    public let name      : String
    /// <#Description#>
    public let localName : String
    
    /// <#Description#>
    public var id              : Double { date.timeIntervalSinceReferenceDate }
    /// <#Description#>
    public var isInWeekend     : Bool   { date.isWeekend }
    /// <#Description#>
    public var isGoodFriday    : Bool   { lowName.hasPrefix("good") }
    /// <#Description#>
    public var isLiberationDay : Bool   { lowName.hasPrefix("liberation") }
    
    /// <#Description#>
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - name: <#name description#>
    ///   - localName: <#localName description#>
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
