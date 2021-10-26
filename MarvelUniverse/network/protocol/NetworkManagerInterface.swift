//
//  NetworkManagerInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

protocol NetworkManagerInterface {
    func fetchObject<T: Codable>(for request: HTTPRequest, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
    func fetchData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
