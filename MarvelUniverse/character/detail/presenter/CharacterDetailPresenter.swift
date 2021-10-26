//
//  CharacterDetailPresenter.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresenterInterface {
    var character: Character
    var details: [DetailSection]
    
    required init(character: Character) {
        self.character = character
        details = []
        setupDetails()
    }
    
    func setupDetails() {
        details.append(.name(string: character.name))
        if !character.description.isEmpty {
            details.append(.description(string: character.description))
        }
        
        let comicsName = character.comics.items.compactMap({ $0.name })
        if !comicsName.isEmpty {
            details.append(.comics(names: comicsName))
        }
        
        let seriesName = character.series.items.compactMap({ $0.name })
        if !seriesName.isEmpty {
            details.append(.series(names: seriesName))
        }
        
        let storiesName = character.stories.items.compactMap({ $0.name })
        if !storiesName.isEmpty {
            details.append(.stories(names: storiesName))
        }
        
        let eventsName = character.events.items.compactMap({ $0.name })
        if !eventsName.isEmpty {
            details.append(.events(names: eventsName))
        }
    }
}
