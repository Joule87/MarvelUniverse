//
//  CharacterRepository.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

class CharacterRepository: CharacterRepositoryInterface, MarvelAPICredential {
    private var networkManager: NetworkManagerInterface
    
    init(networkManager: NetworkManagerInterface) {
        self.networkManager = networkManager
    }
    
    func requestCharacters(offSet: Int ,completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        let charactersPath = "characters"
        var request = HTTPRequest(method: .get, path: charactersPath)
        let queryItems = getURLQueryItems(for: offSet, limit: 50)
        request.queryItems = queryItems
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func requestCharacter(by id: Int, completion: @escaping ((Result<APIResult, NetworkError>) -> Void)) {
        let characterByIdPath = "characters/\(id)"
        var request = HTTPRequest(method: .get, path: characterByIdPath)
        let queryItems = getURLQueryItems()
        request.queryItems = queryItems
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    private func getURLQueryItems(for offSet: Int? = nil, limit: Int? = nil) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = baseQueryItems
        if let offSet = offSet {
            queryItems.append(URLQueryItem(name: "offset", value: String(offSet)))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        return queryItems
    }
}
