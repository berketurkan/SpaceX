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
    
    let id: String
    let name: String
    let description: String
    var imageURL = ""
    var isFavorite: Bool
    let height: Dimension
    let diameter: Dimension
    let mass: Mass
    let flickr_images: [String]
    let payload_weights: [Payload]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case height
        case diameter
        case mass
        case flickr_images
        case payload_weights
    }
    
    init(id: String, name: String, description: String, imageURL: String, isFavorite: Bool, height: Dimension, diameter: Dimension, mass: Mass, flickr_images: [String], payload_weights: [Payload]) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.isFavorite = isFavorite
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.flickr_images = flickr_images
        self.payload_weights = payload_weights
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        height = try container.decode(Dimension.self, forKey: .height)
        diameter = try container.decode(Dimension.self, forKey: .diameter)
        mass = try container.decode(Mass.self, forKey: .mass)
        flickr_images = try container.decode([String].self, forKey: .flickr_images)
        payload_weights = try container.decode([Payload].self, forKey: .payload_weights)
        imageURL = flickr_images.first ?? ""
        isFavorite = false
    }
    
    mutating func toggleFavorite() {
        self.isFavorite.toggle()
    }
    
}

struct Dimension: Decodable, Hashable {
    let meters: Double
    let feet: Double
}

struct Mass: Decodable, Hashable {
    let kg: Double
    let lb: Double
}

struct Payload: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}

struct MockData {
    static let sampleRocket = Rocket(
        id: "000",
        name: "Test Rocket1",
        description: "The Dragon spacecraft is capable of carrying up to 7 passengers to and from Earth orbit, and beyond. It is the only spacecraft currently flying that is capable of returning significant amounts of cargo to Earth, and is the first private spacecraft to take humans to the space station.",
        imageURL: "",
        isFavorite: false,
        height: Dimension(meters: 111, feet: 111),
        diameter: Dimension(meters: 111, feet: 111),
        mass: Mass(kg: 111, lb: 111),
        flickr_images: ["", ""],
        payload_weights: []
    )
    
    static let sampleRocket1 = Rocket(
        id: "001",
        name: "Test Rocket2",
        description: "",
        imageURL: "",
        isFavorite: false,
        height: Dimension(meters: 111, feet: 111),
        diameter: Dimension(meters: 111, feet: 111),
        mass: Mass(kg: 111, lb: 111),
        flickr_images: ["", ""],
        payload_weights: []
    )
    
    static let sampleRocket2 = Rocket(
        id: "002",
        name: "Test Rocket3",
        description: "",
        imageURL: "",
        isFavorite: false,
        height: Dimension(meters: 111, feet: 111),
        diameter: Dimension(meters: 111, feet: 111),
        mass: Mass(kg: 111, lb: 111),
        flickr_images: ["", ""],
        payload_weights: []
    )
    
    static let sampleRocket3 = Rocket(
        id: "003",
        name: "Test Rocket4",
        description: "",
        imageURL: "",
        isFavorite: false,
        height: Dimension(meters: 111, feet: 111),
        diameter: Dimension(meters: 111, feet: 111),
        mass: Mass(kg: 111, lb: 111),
        flickr_images: ["", ""],
        payload_weights: []
    )
    
    static let sampleRockets = [sampleRocket, sampleRocket1, sampleRocket2, sampleRocket3]
}
