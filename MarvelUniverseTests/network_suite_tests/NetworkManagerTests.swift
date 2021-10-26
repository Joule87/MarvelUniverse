//
//  NetworkManagerTests.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import XCTest
@testable import MarvelUniverse

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var session: URLSessionMock!
    let url = URL(string: NetworkConfiguration.baseUrl!)!
    let request = HTTPRequest(method: .get, path: "characters")
    
    override func setUp() {
        session = URLSessionMock()
        networkManager = NetworkManager(session: session)
    }
    
    override func tearDown() {
        session = nil
        networkManager = nil
    }
    
    func test_fetchData_Succeeded() {
        let data = Data(base64Encoded: "data")
        session.data = data
        networkManager.fetchData(from: url, completion: { (result) in
            switch result {
            case .success(let value):
                XCTAssertTrue (data == value)
            case .failure(_):
                XCTAssertNil(false)
            }
        })
    }
    
    func test_fetchData_invalidData() {
        networkManager.fetchData(from: url, completion: { (result) in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .invalidData:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        })
    }
    
    func test_fetchData_Error() {
        session.error = NetworkError.error(errorDescription: "Mocked Error")
        
        networkManager.fetchData(from: url, completion: { (result) in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .error(_):
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        })
    }
    
    func test_fetchObject_Succeeded() {
        let characterData = APICharacterData(offset: 0, limit: 20, total: 1954, count: 0, results: [])
        guard let data = try? JSONEncoder().encode(characterData) else {
            XCTAssert(false)
            return
        }
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        session.data = data
        session.response = urlResponse
        
        let completion: (Result<[APICharacterData], NetworkError>) -> () = { result in
            switch result {
            case .success(let value):
                XCTAssertTrue(value.count == 1)
            case .failure(_):
                XCTAssert(false)
            }
        }
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func test_fetchObject_Error() {
        session.error = NetworkError.error(errorDescription: "Mocked Error")
        let completion: (Result<[APIResult], NetworkError>) -> () = { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .error(_):
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        }
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func test_fetchObject_dataNotFound() {
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.response = urlResponse
        
        let completion: (Result<[APIResult], NetworkError>) -> () = { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .invalidData:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        }
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func test_fetchObject_invalidResponse() {
        let urlResponse = HTTPURLResponse(url: url, statusCode: 503, httpVersion: nil, headerFields: nil)
        session.response = urlResponse
        
        let completion: (Result<[APIResult], NetworkError>) -> () = { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .invalidResponse:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        }
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
    
    func test_fetchObject_decodeError() {
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.response = urlResponse
        session.data = Data()
        
        let completion: (Result<[APIResult], NetworkError>) -> () = { result in
            switch result {
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                switch error {
                case .decodingError:
                    XCTAssert(true)
                default:
                    XCTAssert(false)
                }
            }
        }
        networkManager.fetchObject(for: request, completionHandler: completion)
    }
}
