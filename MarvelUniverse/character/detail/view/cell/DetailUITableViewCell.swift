//
//  DetailUITableViewCell.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import UIKit

class DetailUITableViewCell: UITableViewCell {
    
    static let identifier = "DetailUITableViewCell"

    @IBOutlet weak var contentLabel: UILabel!
    
    func set(text: String, color: UIColor = .white, font: UIFont = UIFont.systemFont(ofSize: 16)) {
        contentLabel.text = text
        contentLabel.textColor = color
        contentLabel.font = font
    }
    
}
