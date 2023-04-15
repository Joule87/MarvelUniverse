//
//  CharacterDetailsTableViewDelegateInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import UIKit

protocol CharacterDetailsTableViewDelegateInterface: UITableViewDelegate, UITableViewDataSource {
    var details: [DetailSection] { get set }
    
    init(details: [DetailSection])
}
