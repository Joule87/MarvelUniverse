//
//  URLQueryItemBuilder.swift
//  MarvelUniverse
//
//  Created by Julio Collado Perez on 4/16/23.
//

import Foundation

struct URLQueryItemBuilder: URLQueryItemBuilderInterface, MarvelAPIURLQueryItemInterface {
    var defaultURLQueryItems: [URLQueryItem] {
        return baseQueryItems
    }
    
    func getURLQueryItems(for offSet: Int? = nil, limit: Int? = nil) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = baseQueryItems
        let offsetKey = "offset"
        let limitKey = "limit"
        if let offSet = offSet {
            queryItems.append(URLQueryItem(name: offsetKey, value: String(offSet)))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: limitKey, value: String(limit)))
        }
        return queryItems
    }
}
