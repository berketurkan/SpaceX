//
//  Rocket.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct Rocket: Hashable, Decodable, Identifiable {
    
    static func == (lhs: Rocket, rhs: Rocket) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    var isFavorite = false
    let heightMeter: Double
    let heightFeet: Double
    let diameterMeter: Double
    let diameterFeet: Double
    let massKg: Double
    let massLb: Double
    let images: [String]
    let payloadWeights: [Payload]
    
}

struct Payload: Decodable,Identifiable, Hashable {
    let id: Int
    let name: String
    let kg: Int
    let lb: Int
}

struct RocketResponse: Decodable {
    let request: [Rocket]
}

struct MockData {
    static let sampleRocket = Rocket(id: 000,
                                     name: "Test Rocket1",
                                     description: "The Dragon spacecraft is capable of carrying up to 7 passengers to and from Earth orbit, and beyond. It is the only spacecraft currently flying that is capable of returning significant amounts of cargo to Earth, and is the first private spacecraft to take humans to the space station.",
                                     imageURL: "TestFalcon",
                                     isFavorite: false,
                                     heightMeter: 111,
                                     heightFeet: 111,
                                     diameterMeter: 111,
                                     diameterFeet: 111,
                                     massKg: 111,
                                     massLb: 111,
                                     images: ["TestRocket","TestRocket"],
                                     payloadWeights: [])
    
    static let sampleRocket1 = Rocket(id: 001,
                                      name: "Test Rocket2",
                                      description: "Amazing",
                                      imageURL: "TestFalcon",
                                      isFavorite: false,
                                      heightMeter: 111,
                                      heightFeet: 111,
                                      diameterMeter: 111,
                                      diameterFeet: 111,
                                      massKg: 111,
                                      massLb: 111,
                                      images: ["TestRocket","TestRocket"],
                                      payloadWeights: [])
    
    static let sampleRocket2 = Rocket(id: 002,
                                      name: "Test Rocket3",
                                      description: "Amazing",
                                      imageURL: "TestFalcon",
                                      isFavorite: false,
                                      heightMeter: 111,
                                      heightFeet: 111,
                                      diameterMeter: 111,
                                      diameterFeet: 111,
                                      massKg: 111,
                                      massLb: 111,
                                      images: ["TestRocket","TestRocket"],
                                      payloadWeights: [])
    
    static let sampleRocket3 = Rocket(id: 003,
                                      name: "Test Rocket4",
                                      description: "Amazing",
                                      imageURL: "TestFalcon",
                                      isFavorite: false,
                                      heightMeter: 111,
                                      heightFeet: 111,
                                      diameterMeter: 111,
                                      diameterFeet: 111,
                                      massKg: 111,
                                      massLb: 111,
                                      images: ["TestRocket","TestRocket"],
                                      payloadWeights: [])
    
    static let sampleRockets = [sampleRocket, sampleRocket1, sampleRocket2, sampleRocket3]
}
