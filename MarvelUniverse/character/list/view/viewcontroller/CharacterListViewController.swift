//
//  CharacterListViewController.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    static let identifier = "CharacterListViewController"

    @IBOutlet weak var characterListTableView: UITableView! {
        didSet {
            characterListTableView.register(UINib(nibName: CharacterTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.identifier)
        }
    }
    
    var tableViewDelegate: CharacterListTableViewDelegateInterface?
    private var presenter: CharacterListPresenterInterface?
    private lazy var errorView: ErrorView = {
        let height = self.view.frame.width * 0.70
        let view = ErrorView(frame: CGRect(x: 0, y: 0, width: height, height: height))
        view.retryAction = {
            self.hideErrorView()
            self.showLoader()
            self.presenter?.getCharacters()
        }
        return view
    }()
    private var isErrorHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "characterList.navigationBar.title".localized
        setupDataSource()
        setupTableViewDelegate()
        showLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getCharacters()
    }

    private func showLoader() {
        view.showRegularLoader(backColor: UIColor.white.withAlphaComponent(0.08))
    }
    
    private func removeLoader() {
        view.removeRegularLoader()
    }
    
    private func setupTableViewDelegate() {
        characterListTableView.delegate = tableViewDelegate
        characterListTableView.dataSource = tableViewDelegate
        characterListTableView.prefetchDataSource = tableViewDelegate
    }
    
    private func setupDataSource() {
        let repository = CharacterRepository(networkManager: NetworkManager())
        presenter = CharacterListPresenter(repository: repository)
        presenter?.delegate = self
        tableViewDelegate = CharacterListTableViewDelegate(delegate: self)
    }
    
    private func showErrorView(with message: String?) {
        if !isErrorHidden {
            return
        }
        characterListTableView.isHidden = true
        errorView.alpha = 0
        errorView.set(error: message)
        view.addSubview(errorView)
        errorView.center = view.center
        
        UIView.animate(withDuration: 0.3) {
            self.errorView.alpha = 1
        }
        isErrorHidden = false
    }
    
    private func hideErrorView() {
        if isErrorHidden {
            return
        }
        characterListTableView.isHidden = false
        errorView.removeFromSuperview()
        isErrorHidden = true
    }
}

//MARK: - PresenterRequestDelegate, Requestable, CharacterListRouterInterface
extension CharacterListViewController: PresenterRequestDelegate, Requestable, CharacterListRouterInterface {
    func failed(errorCode: String?, errorMessage: String?) {
        guard let rawErrorCode = errorCode, let requestErrorCode = CharacterErrorRequestCode(rawValue: rawErrorCode) else {
            return
        }
        switch requestErrorCode {
        case .characterList:
            if let error = errorMessage {
                showErrorView(with: error)
            }
        case .characterById:
            if let error = errorMessage {
                AlertHelper.showBasicAlert(on: self, with: "error".localized, message: error, actionTitle: "close".localized)
            }
        }
        removeLoader()
    }
    
    func succeeded() {
        hideErrorView()
        removeLoader()
        guard let presenter = presenter, !presenter.characterList.isEmpty else {
            showErrorView(with: "characters.error.empty.list".localized)
            return
        }
        tableViewDelegate?.characterList = presenter.characterList
        tableViewDelegate?.totalItems = presenter.totalItems
        characterListTableView.reloadData()
    }
    
    func fetched(character: Character) {
        navigateToDetail(character: character, from: navigationController)
        removeLoader()
    }
}

//MARK: - CharacterListViewController: Selectable, Reloadable
extension CharacterListViewController: Selectable, Reloadable {
    func reload() {
        presenter?.getCharacters()
    }
    
    func didSelect(id: Int) {
        showLoader()
        presenter?.getCharacter(by: id)
    }
  
}
