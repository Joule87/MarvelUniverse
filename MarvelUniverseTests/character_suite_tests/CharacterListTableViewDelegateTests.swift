//
//  CharacterListTableViewDelegateTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class CharacterListTableViewDelegateTests: XCTestCase {

    var delegate: CharacterListTableViewDelegateInterface!
    var didReload = false
    var didSelectItemId: Int?
    var tableView: UITableView!
    
    override func setUp() {
        delegate = CharacterListTableViewDelegate(delegate: self)
        delegate.characterList = MockedMarvelObjects.characterList
        delegate.totalItems = 200
        tableView = UITableView()
    }
    
    override func tearDown() {
        delegate = nil
        didReload = false
        didSelectItemId = nil
        tableView = nil
    }
    
    func test_total_of_rows_in_section() {
        let rows = delegate.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(rows == 30)
    }
    
    func test_cell_type() {
        tableView.register(UINib(nibName: CharacterTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.identifier)
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = delegate.tableView(tableView, cellForRowAt: indexPath)
        XCTAssert(cell is CharacterTableViewCell)
    }
    
    func test_tableView_reload_onWillDisplay() {
        var indexPath = IndexPath(item: 15, section: 0)
        let cell = CharacterTableViewCell()
        delegate.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
        XCTAssertTrue(didReload)
        didReload = false
        
        indexPath.item = 19
        delegate.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
        XCTAssertFalse(didReload)
    }
    
    func test_tableView_didSelect() {
        let indexPath = IndexPath(item: 0, section: 0)
        delegate.tableView?(tableView, didSelectRowAt: indexPath)
        XCTAssert(didSelectItemId == 12345)
    }
    
}

extension CharacterListTableViewDelegateTests: Selectable, Reloadable {
    func didSelect(id: Int) {
        didSelectItemId = id
    }
    
    func reload() {
        didReload = true
    }

}
