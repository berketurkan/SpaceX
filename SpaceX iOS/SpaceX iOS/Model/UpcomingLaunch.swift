//
//  UpcomingLaunch.swift
//  SpaceX iOS
//
//  Created by Vestel on 25.08.2024.
//

import SwiftUI

struct Launch: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
    let flightNumber: Int
    let dateLocal: String
    let dateUTC: String
    let rocket: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case flightNumber = "flight_number"
        case dateLocal = "date_local"
        case dateUTC = "date_utc"
        case rocket
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        dateLocal = try container.decode(String.self, forKey: .dateLocal)
        dateUTC = try container.decode(String.self, forKey: .dateUTC)
        rocket = try container.decode(String.self, forKey: .rocket)
    }
    
    init(id: String, name: String, flightNumber: Int, dateLocal: String, dateUTC: String, rocket: String) {
        self.id = id
        self.name = name
        self.flightNumber = flightNumber
        self.dateLocal = dateLocal
        self.dateUTC = dateUTC
        self.rocket = rocket
    }
    
    static let mockDataLaunch: Launch = Launch(
        id: "6243ae7daf52800c6e91925b",
        name: "O3b mPower 3.4",
        flightNumber: 203,
        dateLocal: "2022-11-30T19:00:00-05:00",
        dateUTC: "2022-12-01T00:00:00.000Z",
        rocket: "5e9d0d95eda69973a809d1ec"
    )
    
    static let mockDataLaunches: [Launch] = [
            Launch(
                id: "6243ae7daf52800c6e91925b",
                name: "O3b mPower 3.4",
                flightNumber: 203,
                dateLocal: "2022-11-30T19:00:00-05:00",
                dateUTC: "2022-12-01T00:00:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925c",
                name: "CRS-26",
                flightNumber: 194,
                dateLocal: "2022-11-21T13:22:00-05:00",
                dateUTC: "2022-11-21T18:22:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925d",
                name: "USSF-44",
                flightNumber: 188,
                dateLocal: "2022-11-01T21:40:00-04:00",
                dateUTC: "2022-11-02T01:40:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925e",
                name: "Starlink 4-36 (v1.5)",
                flightNumber: 188,
                dateLocal: "2022-10-27T14:20:00-04:00",
                dateUTC: "2022-10-27T18:20:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925b",
                name: "O3b mPower 3.4",
                flightNumber: 203,
                dateLocal: "2022-11-30T19:00:00-05:00",
                dateUTC: "2022-12-01T00:00:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925b",
                name: "O3b mPower 3.4",
                flightNumber: 203,
                dateLocal: "2022-11-30T19:00:00-05:00",
                dateUTC: "2022-12-01T00:00:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            ),
            Launch(
                id: "6243ae7daf52800c6e91925b",
                name: "O3b mPower 3.4",
                flightNumber: 203,
                dateLocal: "2022-11-30T19:00:00-05:00",
                dateUTC: "2022-12-01T00:00:00.000Z",
                rocket: "5e9d0d95eda69973a809d1ec"
            )
        ]
}
