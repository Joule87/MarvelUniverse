//
//  CharacterListTableViewDelegate.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import UIKit

typealias TableViewDelegateInterface = UITableViewDelegate & UITableViewDataSource & UITableViewDataSourcePrefetching

final class CharacterListTableViewDelegate: NSObject, TableViewDelegateInterface {
    
    private let presenter: CharacterListPresenterInterface
    private weak var delegate: (Selectable & Reloadable)?
    
    init(delegate: (Selectable & Reloadable)? = nil, presenter: CharacterListPresenterInterface) {
        self.delegate = delegate
        self.presenter = presenter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = presenter.characterList[indexPath.row]
        cell.setup(character: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter.characterList.count < presenter.totalCharactersOnMarvelUniverse,
           indexPath.row >= presenter.characterList.count - 25 {
            delegate?.reload()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = presenter.characterList[indexPath.row].id
        delegate?.didSelect(id: characterId)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if presenter.characterList.count >= presenter.totalCharactersOnMarvelUniverse {
            return
        }
        let downloader = ImageDownloader()
        indexPaths.forEach({ item in
            let imageStringUrl = presenter.characterList[item.row].imageURL
            downloader.fetch(from: imageStringUrl)
        })
    }
}
