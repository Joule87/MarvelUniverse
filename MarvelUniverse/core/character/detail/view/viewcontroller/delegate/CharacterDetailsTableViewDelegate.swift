//
//  CharacterDetailsTableViewDelegate.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import UIKit

class CharacterDetailsTableViewDelegate: NSObject, CharacterDetailsTableViewDelegateInterface {
    var details: [DetailSection]
    
    required init(details: [DetailSection] = []) {
        self.details = details
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        details.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = details[section]
        switch section {
        case .name(_):
            return 1
        case .description(_):
            return 1
        case .comics(names: let comics):
            return comics.count
        case .series(names: let series):
            return series.count
        case .stories(names: let stories):
            return stories.count
        case .events(names: let events):
            return events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailUITableViewCell.identifier) as? DetailUITableViewCell else {
            return UITableViewCell()
        }
        let detail = details[indexPath.section]
        switch detail {
        case .name(string: let name):
            cell.set(text: name, font: UIFont.boldSystemFont(ofSize: 20))
        case .description(string: let description):
            cell.set(text: description, font: UIFont.systemFont(ofSize: 18))
        case .comics(names: let comics):
            let name = comics[indexPath.row]
            cell.set(text: "- \(name)")
        case .series(names: let series):
            let name = series[indexPath.row]
            cell.set(text: "- \(name)")
        case .stories(names: let stories):
            let name = stories[indexPath.row]
            cell.set(text: "- \(name)")
        case .events(names: let events):
            let name = events[indexPath.row]
            cell.set(text: "- \(name)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterView.identifier) as? HeaderFooterView else {
            return nil
        }
        let detail = details[section]
        header.setTitle(text: detail.name, color: UIColor.common.yellowColorN2)
        header.setAccessory(text: detail.items, color: UIColor.common.yellowColorN2)
        header.isSeparatorViewHidden(false)
        header.contentView.backgroundColor = UIColor.common.appThemeBackground
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderFooterView.identifier) as? HeaderFooterView else {
            return nil
        }
        header.contentView.backgroundColor = UIColor.common.appThemeBackground
        header.isSeparatorViewHidden(true)
        header.setTitle(text: nil)
        header.setAccessory(text: nil)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
}
