//
//  MarvelAPIURLQueryItemInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

protocol MarvelAPIURLQueryItemInterface: MarvelAPIKeyInterface {
    var baseQueryItems: [URLQueryItem] { get }
}

extension MarvelAPIURLQueryItemInterface  {
    var baseQueryItems: [URLQueryItem] {
        let timeStampName = "ts"
        let timeStampValue = String(Date().timeIntervalSince1970)
        let apiKeyName = "apikey"
        let hashName = "hash"
        var queryItems = [URLQueryItem(name: timeStampName, value: timeStampValue)]
        if let publicKey = keychain?.publicKey {
            queryItems.append(URLQueryItem(name: apiKeyName, value: publicKey))
        }
        if let md5Hash = getMD5Hash(timeStamp: timeStampValue) {
            queryItems.append(URLQueryItem(name: hashName, value: md5Hash))
        }
        return queryItems
    }
}
