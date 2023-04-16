//
//  CharacterRepository.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

class CharacterRepository: CharacterRepositoryInterface {
    private var networkManager: NetworkManagerInterface
    private let queryItemBuilder: URLQueryItemBuilderInterface
    
    init(networkManager: NetworkManagerInterface, queryItemBuilder: URLQueryItemBuilderInterface = URLQueryItemBuilder()) {
        self.networkManager = networkManager
        self.queryItemBuilder = queryItemBuilder
    }
    
    func requestCharacters(offSet: Int, limit: Int, completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        let charactersPath = "characters"
        var request = HTTPRequest(method: .get, path: charactersPath)
        let queryItems = queryItemBuilder.getURLQueryItems(for: offSet, limit: limit)
        request.queryItems = queryItems
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func requestCharacter(by id: Int, completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        let characterByIdPath = "characters/\(id)"
        var request = HTTPRequest(method: .get, path: characterByIdPath)
        let queryItems = queryItemBuilder.defaultURLQueryItems
        request.queryItems = queryItems
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
}
