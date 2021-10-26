//
//  NetworkError.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(errorDescription: String)
    case decodingError
    case invalidUrl
    
    var customDescription: String {
        switch self {
        case .invalidResponse:
            return "invalid.response.error".localized
        case .invalidData:
            return "data.error".localized
        case .error(errorDescription: let errorDescription):
            return errorDescription
        case .decodingError:
            return "data.error".localized
        case .invalidUrl:
            return "data.error".localized
        }
    }
}
