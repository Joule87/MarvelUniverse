//
//  CharacterListViewModel.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

struct CharacterListViewModel {
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    let comics: SelectionViewModel
    let series: SelectionViewModel
    let stories: SelectionViewModel
    let events: SelectionViewModel
}
