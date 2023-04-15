//
//  CharacterRepositoryInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

protocol CharacterRepositoryInterface {
    ///Request a list of characters, execute completion bock on response
    func requestCharacters(offSet: Int, limit: Int, completion: @escaping ((Result<APIResult,NetworkError>) -> Void))
    ///Request a character given and id, execute completion bock on response
    func requestCharacter(by id: Int, completion: @escaping ((Result<APIResult,NetworkError>) -> Void))
}
