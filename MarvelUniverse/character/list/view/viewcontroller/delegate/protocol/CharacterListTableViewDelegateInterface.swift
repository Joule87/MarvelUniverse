//
//  CharacterListTableViewDelegateInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import UIKit

protocol CharacterListTableViewDelegateInterface: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    var characterList: [CharacterListViewModel] { get set }
}
