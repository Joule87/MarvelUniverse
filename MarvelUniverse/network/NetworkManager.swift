//
//  NetworkManager.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

struct NetworkManager: NetworkManagerInterface {
    
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
        
        session.dataTask(with: urlRequest) { data, response , error in
            if let unwrappedError = error {
                logger.log(category: .repository, message: "Fetch failed with error: \(unwrappedError.localizedDescription)", access: .public, type: .debug)
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(errorDescription: unwrappedError.localizedDescription)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                logger.log(category: .repository, message: "\(response.debugDescription)", access: .public, type: .debug)
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.invalidData))
                }
                return
            }
            
            do {
                let jsonObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(jsonObject))
                }
            } catch let decodeError {
                if let error = decodeError as? DecodingError {
                    switch error {
                    case .typeMismatch(let key, let value):
                        logger.log(category: .repository, message: "Mismatch Error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .valueNotFound(let key, let value):
                        logger.log(category: .repository, message: "Value not Error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .keyNotFound(let key, let value):
                        logger.log(category: .repository, message: "Key not found error: \(key), value: \(value), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    case .dataCorrupted(let key):
                        logger.log(category: .repository, message: "Data Corrupted error: \(key), Description: \(error.localizedDescription)", access: .public, type: .debug)
                    default:
                        logger.log(category: .repository, message: "ERROR: \(error.localizedDescription)", access: .public, type: .debug)
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(.failure(.decodingError))
                }
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
                DispatchQueue.main.async {
                    completion(.failure(.error(errorDescription: error.localizedDescription)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
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
