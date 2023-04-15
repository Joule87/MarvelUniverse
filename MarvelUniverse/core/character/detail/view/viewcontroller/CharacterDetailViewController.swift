//
//  CharacterDetailViewController.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 21/10/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    static let identifier = "CharacterDetailViewController"
    
    @IBOutlet weak var characterDetailTableView: UITableView! {
        didSet {
            setupTableViewHeader()
            registerTableViewCells()
        }
    }
    
    var tableViewDelegate: CharacterDetailsTableViewDelegateInterface?
    var presenter: CharacterDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "characterDetails.navigationBar.title".localized
        navigationController?.navigationBar.tintColor = .white
        setupTableViewDelegate()
    }
    
    private func setupTableViewDelegate() {
        characterDetailTableView.delegate = tableViewDelegate
        characterDetailTableView.dataSource = tableViewDelegate
    }
    
    private func setupTableViewHeader() {
        let headerView = CharacterProfileView(frame: CGRect(x: 0, y: 0, width: characterDetailTableView.bounds.size.width, height: 300))
        let imageURL = presenter?.character.thumbnail.stringURL ?? ""
        headerView.set(imageURL: imageURL)
        characterDetailTableView.tableHeaderView = headerView
    }
    
    private func registerTableViewCells() {
        characterDetailTableView.register(UINib(nibName: HeaderFooterView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderFooterView.identifier)
        characterDetailTableView.register(UINib(nibName: DetailUITableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailUITableViewCell.identifier)
    }
    
}
