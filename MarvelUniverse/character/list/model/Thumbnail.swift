//
//  Thumbnail.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let extensionFormat: String
    var stringURL: String {
        return "\(path).\(extensionFormat)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case extensionFormat = "extension"
    }
}
