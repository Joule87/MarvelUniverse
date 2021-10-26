//
//  CharacterTableViewCell.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    
    @IBOutlet weak var accessoryImageView: UIImageView! {
        didSet {
            let icon = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
            accessoryImageView.image = icon
            accessoryImageView.tintColor = .white
        }
    }
    
    @IBOutlet weak var networkImageView: NetworkImageView! {
        didSet {
            networkImageView.layer.masksToBounds = true
            networkImageView.layer.cornerRadius = 10
        }
    }
    
    func setup(character: CharacterListViewModel) {
        nameLabel.text = character.name
        networkImageView.loadImageFrom(url: character.imageURL)
        comicsLabel.text = "\("comics".localized): \(character.comics.amount)"
        seriesLabel.text = "\("series".localized): \(character.series.amount)"
        storiesLabel.text = "\("stories".localized): \(character.stories.amount)"
        eventsLabel.text = "\("events".localized): \(character.events.amount)"
    }
    
}
