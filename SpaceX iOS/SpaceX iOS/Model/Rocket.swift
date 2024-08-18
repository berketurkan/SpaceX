//
//  Rocket.swift
//  SpaceX iOS
//
//  Created by Vestel on 13.08.2024.
//

import SwiftUI

struct Rocket: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    var isFavorite = false
    let heightMeter: Float
    let heightFeet: Float
    let diameterMeter: Float
    let diameterFeet: Float
    let massKg: Float
    let massLb: Float
    let images: [String]
    let payloadWeights: [Payload]
    
}

struct Payload: Decodable,Identifiable {
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
                                     name: "Test Rocket",
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
    
    static let sampleRocket1 = Rocket(id: 001,
                                      name: "Test Rocket",
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
                                      name: "Test Rocket",
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
                                      name: "Test Rocket",
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
