//
//  Movie.swift
//  StarWars
//
//  Created by Sophie SONG on 18/12/2020.
//

import Foundation

class Movie: Decodable {

    /// Movie's title
    let title: String

    /// Movie episode ID
    let episodeId: Int?
    
    /// Movie's opening crawl
    let openingCrawl: String

    /// Movie's director
    let director: String
    
    /// Movie's producer
    let producer: String
    
    /// Release Date
    let releaseDate: Date?
    
    /// Number of characters on the movie
    let numberOfCharacters: Int?


    enum CodingKeys: String, CodingKey {
        case title = "movieTitle"
        case episodeId
        case openingCrawl
        case director = "movieDirector"
        case producer = "movieProducer"
        case releaseDate
        case numberOfCharacters

    }

    //
    // MARK: - Initialization
    //

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.episodeId = try container.decode(Int.self, forKey: .episodeId)
        self.openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
        self.director = try container.decode(String.self, forKey: .director)
        self.producer = try container.decode(String.self, forKey: .producer)
        self.releaseDate = try container.decodeIfPresent(Date.self, forKey: .releaseDate)
        self.numberOfCharacters = try container.decode(Int.self, forKey: .numberOfCharacters)

    }

}
