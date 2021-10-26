//
//  CharacterListRouterInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 22/10/21.
//

import UIKit

protocol CharacterListRouterInterface {
    func navigateToDetail(character: Character, from navigationViewController: UINavigationController?)
}

extension CharacterListRouterInterface {
    func navigateToDetail(character: Character, from navigationViewController: UINavigationController?) {
        let storyboardName = "Main"
        guard let characterDetailsViewController = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: CharacterDetailViewController.identifier) as? CharacterDetailViewController else {
            return
        }
        let presenter = CharacterDetailPresenter(character: character)
        characterDetailsViewController.presenter = presenter
        characterDetailsViewController.tableViewDelegate = CharacterDetailsTableViewDelegate(details: presenter.details)
        navigationViewController?.pushViewController(characterDetailsViewController, animated: true)
    }
}
