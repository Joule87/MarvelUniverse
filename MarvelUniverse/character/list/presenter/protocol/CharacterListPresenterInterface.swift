//
//  CharacterListPresenterInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

protocol CharacterListPresenterInterface {
    var characterList: [CharacterListViewModel] { get set }
    var delegate: (PresenterRequestDelegate & Requestable)? { get set }
    
    init(repository: CharacterRepositoryInterface)
    
    func getCharacters()
    func getCharacter(by id: Int)
}
