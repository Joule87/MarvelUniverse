//
//  ImageDownloader.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//


import XCTest
@testable import MarvelUniverse

class ImageDownloaderTests: XCTestCase {
    private var imageDownloader: Downloadable!
    private var networkManager: NetworkManager!
    private var session: URLSessionMock!
    
    override func setUp() {
        session = URLSessionMock()
        networkManager = NetworkManager(session: session)
        imageDownloader = ImageDownloader(networkManager: networkManager)
    }
    
    override func tearDown() {
        imageDownloader = nil
        session = nil
        networkManager = nil
    }
    
    func test_downloadImage_succeeded() {
        imageDataCache.removeAllObjects()
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(string: NetworkConfiguration.baseUrl!)!.absoluteString
        imageDownloader.fetch(from: url) { value in
            XCTAssert(data == value)
        }
    }
    
    func test_downloadImage_failed() {
        session.error = NetworkError.error(errorDescription: "Mocked Error")
        let url = URL(string: NetworkConfiguration.baseUrl!)!.absoluteString
        imageDownloader.fetch(from: url) { value in
            XCTAssertNil(value)
        }
    }
}
