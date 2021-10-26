//
//  CharacterPresenterTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class CharacterPresenterTests: XCTestCase {
    var presenter: CharacterListPresenterInterface!
    var repository: MockedCharacterRepository!
    
    private var lastErrorMessage: String?
    private var requestSucceeded: Bool?
    private var characterDetail: Character?
    
    override func setUp() {
        repository = MockedCharacterRepository()
        presenter = CharacterListPresenter(repository: repository)
        presenter.delegate = self
    }
    
    override func tearDown() {
        repository = nil
        presenter = nil
        lastErrorMessage = nil
        requestSucceeded = nil
        characterDetail = nil
    }
    
    func test_getCharacters_succeeded_noEmptyList() {
        repository.mockedAmount = 10
        presenter.getCharacters()
        XCTAssert(presenter.characterList.count == 10)
        XCTAssertTrue(requestSucceeded ?? false)
    }
    
    func test_getCharacters_succeeded_emptyList() {
        repository.mockedAmount = 0
        presenter.getCharacters()
        XCTAssert(presenter.characterList.count == 0)
        XCTAssertTrue(requestSucceeded ?? false)
    }
    
    func test_getCharacters_failed_invalidResponse() {
        repository.expectedResult = .failed
        presenter.getCharacters()
        XCTAssert(lastErrorMessage == NetworkError.invalidResponse.customDescription)
        XCTAssertFalse(requestSucceeded ?? true)
    }
    
    func test_getCharacterById_failed_invalidData() {
        repository.expectedResult = .failed
        presenter.getCharacter(by: 0)
        XCTAssert(lastErrorMessage == NetworkError.invalidData.customDescription)
        XCTAssertFalse(requestSucceeded ?? true)
    }
    
    func test_getCharacterById_succeeded() {
        repository.expectedResult = .succeeded
        repository.mockedAmount = 1
        presenter.getCharacter(by: 0)
        XCTAssertTrue(requestSucceeded ?? false)
        XCTAssert(characterDetail?.name == "someName")
        XCTAssert(characterDetail?.description == "someDescription")
    }
}

extension CharacterPresenterTests: PresenterRequestDelegate, Requestable {
    func failed(errorCode: String?, errorMessage: String?) {
        lastErrorMessage = errorMessage
        requestSucceeded = false
    }
    
    func succeeded() {
        requestSucceeded = true
    }
    
    func fetched(character: Character) {
        requestSucceeded = true
        characterDetail = character
    }
    
}
