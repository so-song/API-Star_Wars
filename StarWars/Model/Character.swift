//
//  Character.swift
//  StarWars
//
//  Created by Sophie SONG on 18/12/2020.
//

import Foundation

class Character: Decodable {

    /// Character's name
    let name: String

    /// Character's height
    let height: String
    
    /// Character's mass
    let mass: String
    
    /// Character's hair color
    let hairColor: String
    
    /// Character's birth year
    let birthYear: String
    
    /// Character's gender
    let gender: String
    
    /// Number of films
    let numberOfFilms: Int?
    
    /// Number of species
    let numberOfSpecies: Int?

    /// Number of starships
    let numberOfStarships: Int?


    enum CodingKeys: String, CodingKey {
        case name = "characterName"
        case height = "characterHeight"
        case mass = "characterMass"
        case hairColor
        case birthYear
        case gender = "characterGender"
        case numberOfFilms
        case numberOfSpecies
        case numberOfStarships

    }

    //
    // MARK: - Initialization
    //

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(String.self, forKey: .height)
        self.mass = try container.decode(String.self, forKey: .mass)
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
        self.birthYear = try container.decode(String.self, forKey: .birthYear)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.numberOfFilms = try container.decode(Int.self, forKey: .numberOfFilms)
        self.numberOfSpecies = try container.decode(Int.self, forKey: .numberOfSpecies)
        self.numberOfStarships = try container.decode(Int.self, forKey: .numberOfStarships)



    }

}
