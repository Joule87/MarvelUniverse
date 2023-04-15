//
//  HeaderView.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import UIKit

class HeaderFooterView: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderFooterView"
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text =  nil
        }
    }
    @IBOutlet weak var accessoryLabel: UILabel! {
        didSet {
            accessoryLabel.text =  nil
        }
    }
    
    @IBOutlet weak var separatorView: UIView!
    
    func setTitle(text: String?, color: UIColor = .white, font: UIFont = UIFont.boldSystemFont(ofSize: 32)) {
        titleLabel.text = text
        titleLabel.textColor = color
        titleLabel.font = font
    }
    
    func setAccessory(text: String?, color: UIColor = .white, font: UIFont = UIFont.boldSystemFont(ofSize: 24)) {
        accessoryLabel.text = text
        accessoryLabel.textColor = color
        accessoryLabel.font = font
    }
    
    func isSeparatorViewHidden(_ isHidden: Bool) {
        separatorView.isHidden = isHidden
    }
    
}
