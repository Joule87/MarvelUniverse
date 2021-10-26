//
//  CharacterListTableViewDelegate.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import UIKit

class CharacterListTableViewDelegate: NSObject, CharacterListTableViewDelegateInterface {
    
    var characterList: [CharacterListViewModel] = []
    private weak var delegate: (Selectable & Reloadable)?
    
    init(delegate: (Selectable & Reloadable)? = nil) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = characterList[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characterList.count - 15 {
            delegate?.reload()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = characterList[indexPath.row].id
        delegate?.didSelect(id: characterId)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let downloader = ImageDownloader()
        indexPaths.forEach({ item in
            let imageStringUrl = characterList[item.row].imageURL
            downloader.fetch(from: imageStringUrl)
        })
    }
}
