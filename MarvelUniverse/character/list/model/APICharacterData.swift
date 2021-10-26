//
//  APICharacterData.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

struct APICharacterData: Codable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [Character]
}
