//
//  CharacterResponse.swift
//  StarWars
//
//  Created by Sophie SONG on 18/12/2020.
//

import Foundation

class CharacterResponse: Decodable {

    var resultCount: Int = 0
    var results: [Character] = []

    init(resultsCount: Int, results: [Character]) {
        self.resultCount = resultsCount
        self.results = results
    }

}
