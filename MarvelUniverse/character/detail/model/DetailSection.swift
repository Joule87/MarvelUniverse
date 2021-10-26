//
//  DetailSection.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

enum DetailSection {
    case name(string: String)
    case description(string: String)
    case comics(names: [String])
    case series(names: [String])
    case stories(names: [String])
    case events(names: [String])
    
    var name: String {
        switch self {
        case .name(string: _):
            return "✧  \("name".localized)"
        case .description(string: _):
            return "✧  \("description".localized)"
        case .comics(names: _):
            return "✧  \("comics".localized)"
        case .series(names: _):
            return "✧  \("series".localized)"
        case .stories(names: _):
            return "✧  \("stories".localized)"
        case .events(names: _):
            return "✧  \("events".localized)"
        }
    }
    
    var items: String? {
        switch self {
        case .name(string: _):
            return nil
        case .description(string: _):
            return nil
        case .comics(names: let comics):
            return String(comics.count)
        case .series(names: let series):
            return String(series.count)
        case .stories(names: let stories):
            return String(stories.count)
        case .events(names: let events):
            return String(events.count)
        }
    }
    
}
