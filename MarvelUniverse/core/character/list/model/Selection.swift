//
//  Selection.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import Foundation

struct Selection: Codable {
    let available: Int
    let items: [Item]
    let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case items = "items"
        case returned
    }
}

