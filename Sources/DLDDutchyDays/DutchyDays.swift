//
//  DutchyDays.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// <#Description#>
public struct DutchyDays {
    /// <#Description#>
    public let year: Int
    /// <#Description#>
    public let liberationOccurrence: DDLiberationOccurrence
    /// <#Description#>
    public let exclusions: DDExclusions
    
    /// <#Description#>
    /// - Parameters:
    ///   - year: <#year description#>
    ///   - liberationOccurrence: <#liberationOccurrence description#>
    ///   - exclusions: <#exclusions description#>
    public init(year: Int, liberationOccurrence: DDLiberationOccurrence, exclusions: DDExclusions) {
        self.year = year
        self.liberationOccurrence = liberationOccurrence
        self.exclusions = exclusions
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - year: <#year description#>
    ///   - liberationOccurrence: <#liberationOccurrence description#>
    ///   - exclusions: <#exclusions description#>
    /// - Returns: <#description#>
    public static func getHolidays(in year: Int = .thisYear,
                                   liberationOccurrence: DDLiberationOccurrence = .always,
                                   exclusions: DDExclusions = []) async -> [DDHoliday] {
        let dutchy = DutchyDays(year: year, liberationOccurrence: liberationOccurrence, exclusions: exclusions)
        return await dutchy.fetchHolidays()
    }
}

private extension DutchyDays {
    var apiAddress         : String { "https://date.nager.at/api/v3/PublicHolidays/\(year.string)/NL" }
    var excludeWeekends    : Bool   { exclusions.contains(.weekends) }
    var excludeGoodFriday  : Bool   { exclusions.contains(.goodFriday) }
    var isQuinquennialYear : Bool   { year.isMultiple(of: 5) }
}

private extension DutchyDays {
    func fetchHolidays() async -> [DDHoliday] {
        var holidays = await fetchAllDates()
        if excludeWeekends { holidays.removeWeekends() }
        if excludeGoodFriday { holidays.removeGoodFriday() }
        holidays.removeLiberation(withOccurrence: liberationOccurrence, isQuinYear: isQuinquennialYear)
        
        return holidays.sorted(by: \.date)
    }
    
    func fetchAllDates() async -> [DDHoliday] {
        guard let url = URL(string: apiAddress) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let holidays = try data.jsonDecode([DDHoliday].self, using: .holidayDecoder)
            
            return holidays
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}

fileprivate extension JSONDecoder {
    static var holidayDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter(format: .yMMdd))
        return decoder
    }
}
