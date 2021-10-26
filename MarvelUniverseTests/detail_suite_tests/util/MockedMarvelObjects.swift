//
//  MockedCharacter.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import Foundation
@testable import MarvelUniverse

struct MockedMarvelObjects {
    static let character: Character = {
        let characterName = "solana"
        let characterDescription = "someDescription"
        let item = Item(name: "name")
        let comics = Selection(available: 11, items: Array.init(repeating: item, count: 11), returned: 11)
        let series = Selection(available: 22, items: Array.init(repeating: item, count: 22), returned: 22)
        let stories = Selection(available: 4, items: Array.init(repeating: item, count: 4), returned: 4)
        let events = Selection(available: 0, items: [], returned: 0)
        let thumbnail = Thumbnail(path: "path", extensionFormat: "extensionFormat")
        let character = Character(id: 0, name: characterName, description: characterDescription, thumbnail: thumbnail, comics: comics, series: series, stories: stories, events: events)
        return character
    }()
    
    static let characterList: [CharacterListViewModel] = {
        var characters: [CharacterListViewModel] = []
        let selectionViewModel = SelectionViewModel(amount: "10", items: Array.init(repeating: Item(name: "name"), count: 10))
        let model1 = CharacterListViewModel(id: 12345, name: "name1",
                                           description: "desc1",
                                           imageURL: "none1",
                                           comics: selectionViewModel,
                                           series: selectionViewModel,
                                           stories: selectionViewModel,
                                           events: selectionViewModel)
        let model2 = CharacterListViewModel(id: 2, name: "name2",
                                           description: "desc2",
                                           imageURL: "none2",
                                           comics: selectionViewModel,
                                           series: selectionViewModel,
                                           stories: selectionViewModel,
                                           events: selectionViewModel)
        characters.append(model1)
        characters.append(contentsOf: Array(repeating: model2, count: 29))
        return characters
    }()
}
