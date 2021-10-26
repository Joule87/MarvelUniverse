//
//  URLSessionDataTaskMock.swift
//  MarvelUniverseTests
//
//  Created by Julio Collado on 25/10/21.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
