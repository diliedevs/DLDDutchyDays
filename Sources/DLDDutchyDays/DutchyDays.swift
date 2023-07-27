//
//  DutchyDays.swift
//  DLDDutchyDays
//
//  Created by Dionne Lie-Sam-Foek on 12/05/2022.
//

import Foundation
import DLDFoundation

/// A utility struct for retrieving Dutch holidays.
public struct DutchyDays {
    
    /// The year for which to retrieve holidays.
    public let year: Int
    
    /// The occurrence of Liberation Day.
    public let liberationOccurrence: DDLiberationOccurrence
    
    /// The exclusions for certain dates.
    public let exclusions: DDExclusions
    
    /// Initializes a new instance of `DutchyDays` with the provided information.
    ///
    /// - Parameters:
    ///   - year: The year for which to retrieve holidays.
    ///   - liberationOccurrence: The occurrence of Liberation Day.
    ///   - exclusions: The exclusions for certain dates.
    public init(year: Int, liberationOccurrence: DDLiberationOccurrence, exclusions: DDExclusions) {
        self.year = year
        self.liberationOccurrence = liberationOccurrence
        self.exclusions = exclusions
    }
    
    /// Retrieves the holidays for the specified year.
    ///
    /// - Parameters:
    ///   - year: The year for which to retrieve holidays. Defaults to the current year.
    ///   - liberationOccurrence: The occurrence of Liberation Day. Defaults to `.always`.
    ///   - exclusions: The exclusions for certain dates. Defaults to an empty set of exclusions.
    /// - Returns: An array of `DDHoliday` representing the holidays.
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
            let holidays = try data.decodeJSON([DDHoliday].self, using: .holidayDecoder)
            
            return holidays
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}

fileprivate extension JSONDecoder {
    static var holidayDecoder: JSONDecoder {
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd"
        
        return JSONDecoder(dateDecodingStrategy: .formatted(df))
    }
}
