//
//  CharacterListRouterInterfaceTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class CharacterListRouterInterfaceTests: XCTestCase, CharacterListRouterInterface {

    func test_router() {
        let navigation = UINavigationController()
        XCTAssert(navigation.children.count == 0)
        navigateToDetail(character: MockedMarvelObjects.character, from: navigation)
        XCTAssert(navigation.children.count == 1)
        XCTAssert(navigation.children.first is CharacterDetailViewController)
    }
}
