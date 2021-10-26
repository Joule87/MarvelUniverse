//
//  HTTPRequestTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class HTTPRequestTests: XCTestCase {
    var httpRequest: HTTPRequest!
    
    func test_create_HTTPRequest() {
        let url = URL(string: NetworkConfiguration.baseUrl!)!
        let path = "characters"
        httpRequest = HTTPRequest(method: .get, url: url, path: path)
        XCTAssert(httpRequest.method == .get)
        XCTAssert(httpRequest.path == path)
    }

}
