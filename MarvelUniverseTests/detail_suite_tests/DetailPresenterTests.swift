//
//  DetailPresenterTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class DetailPresenterTests: XCTestCase {
    var presenter: CharacterDetailPresenterInterface!
    
    func test_detail_data_viewModel() {
        let characterName = "solana"
        let characterDescription = "someDescription"
        let character = MockedMarvelObjects.character
        presenter = CharacterDetailPresenter(character: character)
        
        XCTAssert( presenter.details.count == 5)
        
        var comicSectionItems: Int = 0
        var seriesSectionItems: Int = 0
        var storiesSectionItems: Int = 0
        var eventsSectionItems: Int = 0
        var sectionCharacterName = ""
        var sectionCharacterDescription = ""
        
        presenter.details.forEach({ detailSection in
            switch detailSection {
            case .name(string: let string):
                sectionCharacterName = string
            case .description(string: let string):
                sectionCharacterDescription = string
            case .comics(names: let comics):
                comicSectionItems = comics.count
            case .series(names: let series):
                seriesSectionItems = series.count
            case .stories(names: let stories):
                storiesSectionItems = stories.count
            case .events(names: let events):
                eventsSectionItems = events.count
            }
        })
        
        XCTAssertTrue(sectionCharacterName == characterName)
        XCTAssertTrue(sectionCharacterDescription == characterDescription)
        XCTAssertTrue(comicSectionItems == character.comics.items.count)
        XCTAssertTrue(seriesSectionItems == character.series.items.count)
        XCTAssertTrue(storiesSectionItems == character.stories.items.count)
        XCTAssertTrue(eventsSectionItems == character.events.items.count)
    }
    
    
}
