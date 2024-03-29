//
//  NetworkManager.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

class NetworkManager: NetworkManagerInterface {
    
    private var session: URLSession
    private let logger = Logger()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Performs request and decode the data
    /// - Parameters:
    ///   - url: url object
    ///   - completion: handler called upon request completion
    func fetchObject<T: Codable>(for request: HTTPRequest, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = getUrlRequest(from: request) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        session.dataTask(with: urlRequest) { [weak self] data, response , error in
            guard let self = self else { return }
            if let unwrappedError = error {
                self.logger.log(category: .repository, message: "Fetch failed with error: \(unwrappedError.localizedDescription)", access: .public, type: .debug)
                completionHandler(.failure(.error(errorDescription: unwrappedError.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                self.logger.log(category: .repository, message: "\(response.debugDescription)", access: .public, type: .debug)
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let jsonObject = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(jsonObject))
            } catch let decodeError {
                if let error = decodeError as? DecodingError {
                    switch error {
                    case .typeMismatch(let key, let value):
                        self.logger.log(category: .repository, message: "Mismatch Error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .valueNotFound(let key, let value):
                        self.logger.log(category: .repository, message: "Value not Error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .keyNotFound(let key, let value):
                        self.logger.log(category: .repository, message: "Key not found error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .dataCorrupted(let key):
                        self.logger.log(category: .repository, message: "Data Corrupted error: \(key), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    default:
                        self.logger.log(category: .repository, message: "ERROR: \(error.localizedDescription)", access: .public, type: .debug)
                    }
                }
                completionHandler(.failure(.decodingError))
            }
        }.resume()
    }
    
    /// Performs request  and returns the data as it is from given URL
    /// - Parameters:
    ///   - url: url object
    ///   - completion: handler called upon request completion
    func fetchData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let urlSessionDataTask = session.dataTask(with: url) { data, _ , error in
            if let error = error {
                completion(.failure(.error(errorDescription: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
            
        }
        urlSessionDataTask.priority = URLSessionTask.highPriority
        urlSessionDataTask.resume()
    }
}

extension NetworkManager {
    private func getUrlRequest(from request: HTTPRequest) -> URLRequest? {
        let baseUrl = request.baseUrl
        guard var urlComponents = URLComponents(string: baseUrl.absoluteString) else {
            return nil
        }
        urlComponents.queryItems = request.queryItems
        
        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        return urlRequest
    }
}
