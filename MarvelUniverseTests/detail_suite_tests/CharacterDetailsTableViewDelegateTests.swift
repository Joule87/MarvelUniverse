//
//  CharacterDetailsTableViewDelegateTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class CharacterDetailsTableViewDelegateTests: XCTestCase {
    
    var delegate: CharacterDetailsTableViewDelegateInterface!
    
    override func setUp() {
        let sectionName = DetailSection.name(string: "solana")
        let sectionDescription = DetailSection.name(string: "solana")
        let comicSection = DetailSection.comics(names: ["name1", "name2", "name3", "name4"])
        delegate = CharacterDetailsTableViewDelegate(details: [sectionName, sectionDescription, comicSection])
    }
    
    override func tearDown() {
        delegate = nil
    }
    
    func test_total_of_sections() {
        let numberOfSections = delegate.numberOfSections?(in: UITableView())
        XCTAssertTrue(numberOfSections == 3)
    }
    
    func test_total_of_rows_in_section() {
        let comicSectionNumber = delegate.details.count - 1
        let rows = delegate.tableView(UITableView(), numberOfRowsInSection: comicSectionNumber)
        XCTAssertTrue(rows == 4)
    }
    
    func test_cell_type() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: DetailUITableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailUITableViewCell.identifier)
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = delegate.tableView(tableView, cellForRowAt: indexPath)
        XCTAssert(cell is DetailUITableViewCell)
    }
    
    func test_header_footer_type() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: HeaderFooterView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderFooterView.identifier)
        let headerView = delegate.tableView?(tableView, viewForHeaderInSection: 0)
        XCTAssert(headerView is HeaderFooterView)
        
        let footerView = delegate.tableView?(tableView, viewForFooterInSection: 0)
        XCTAssert(footerView is HeaderFooterView)
    }
    
    func test_header_footer_height() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: HeaderFooterView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderFooterView.identifier)
        let headerHeight = delegate.tableView?(tableView, heightForHeaderInSection: 0)
        
        XCTAssert(headerHeight == 50)
        
        let footerHeight = delegate.tableView?(tableView, heightForFooterInSection: 30)
        XCTAssert(footerHeight == 30)
    }
    
}
