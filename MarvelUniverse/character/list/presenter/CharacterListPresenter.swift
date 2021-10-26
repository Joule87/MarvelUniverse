//
//  CharacterListPresenter.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

class CharacterListPresenter: CharacterListPresenterInterface {
    var characterList: [CharacterListViewModel] = []
    var totalItems: Int = 0
    var repository: CharacterRepositoryInterface
    weak var delegate: (PresenterRequestDelegate & Requestable)?
    
    var data: APICharacterData? {
        didSet {
            let newRequestedCharacterList = data?.results.map {
                CharacterListViewModel(id: $0.id,
                                       name: $0.name,
                                       description: $0.description,
                                       imageURL: $0.thumbnail.stringURL,
                                       comics: SelectionViewModel(amount: "\($0.comics.returned)/\($0.comics.available)", items: $0.comics.items),
                                       series: SelectionViewModel(amount: "\($0.series.returned)/\($0.series.available)", items: $0.series.items),
                                       stories: SelectionViewModel(amount: "\($0.stories.returned)/\($0.stories.available)", items: $0.stories.items),
                                       events: SelectionViewModel(amount: "\($0.events.returned)/\($0.events.available)", items: $0.events.items))
            } ?? []
            characterList.append(contentsOf: newRequestedCharacterList)
            totalItems = data?.total ?? 0
            delegate?.succeeded()
        }
    }
    
    required init(repository: CharacterRepositoryInterface) {
        self.repository = repository
    }
    
    /// Gets character list
    func getCharacters() {
        let offSet = characterList.count
        if offSet != 0 && offSet == data?.total {
            return
        }
        repository.requestCharacters(offSet: offSet) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.data = value.data
                case .failure(let error):
                    self.delegate?.failed(errorCode: CharacterErrorRequestCode.characterList.rawValue, errorMessage: error.customDescription)
                }
            }
        }
    }
    
    /// Gets character by id
    func getCharacter(by id: Int) {
        repository.requestCharacter(by: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let character = value.data.results.first {
                        self.delegate?.fetched(character: character)
                    }
                case .failure(let error):
                    self.delegate?.failed(errorCode: CharacterErrorRequestCode.characterById.rawValue, errorMessage: error.customDescription)
                }
            }
        }
    }
}

enum CharacterErrorRequestCode: String {
    case characterList = "0"
    case characterById = "1"
}
