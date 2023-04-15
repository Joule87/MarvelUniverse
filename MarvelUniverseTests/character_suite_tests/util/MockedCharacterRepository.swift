//
//  MockedCharacterRepository.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import Foundation
@testable import MarvelUniverse

enum ResultStatus {
    case succeeded
    case failed
}

class MockedCharacterRepository: CharacterRepositoryInterface {
    
    var expectedResult: ResultStatus = .succeeded
    var mockedAmount: Int
    
    init(mockedAmount: Int = 0) {
        self.mockedAmount = mockedAmount
    }
    
    func requestCharacters(offSet: Int, limit: Int, completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        switch expectedResult {
        case .succeeded:
            handleSucceededCharacters(completion: completion)
        case .failed:
            handleFailedCharacters(completion: completion)
        }
    }
    
    func requestCharacter(by id: Int, completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        switch expectedResult {
        case .succeeded:
            handleSucceededCharacterById(completion: completion)
        case .failed:
            handleFailedCharacterById(completion: completion)
        }
    }
    
    private func handleSucceededCharacters(completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        return completion(.success(mockedAPIResult))
    }
    
    private func handleFailedCharacters(completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        completion(.failure(.invalidResponse))
    }
    
    private func handleSucceededCharacterById(completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        return completion(.success(mockedAPIResult))
    }
    
    private func handleFailedCharacterById(completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        completion(.failure(.invalidData))
    }
    
    private var mockedAPIResult: APIResult {
        let item = Item(name: "name")
        let selection = Selection(available: 1, items: [item], returned: 1)
        let thumbnail = Thumbnail(path: "path", extensionFormat: "extensionFormat")
        let character = Character(id: 1, name: "someName", description: "someDescription", thumbnail: thumbnail, comics: selection, series: selection, stories: selection, events: selection)
        let characters = Array.init(repeating: character, count: mockedAmount)
        let data = APICharacterData(offset: 0, limit: 20, total: 1555, count: 0, results: characters)
        return APIResult(data: data)
    }
}
