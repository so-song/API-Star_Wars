//
//  MovieResponse.swift
//  StarWars
//
//  Created by Sophie SONG on 18/12/2020.
//

import Foundation

class MovieResponse: Decodable {

    var resultCount: Int = 0
    var results: [Movie] = []

    init(resultsCount: Int, results: [Movie]) {
        self.resultCount = resultsCount
        self.results = results
    }

}
