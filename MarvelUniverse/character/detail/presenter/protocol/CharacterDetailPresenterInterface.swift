//
//  CharacterDetailPresenterInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

protocol CharacterDetailPresenterInterface {
    var character: Character { get set }
    var details: [DetailSection] { get set }
    
    init(character: Character)
}
