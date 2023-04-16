//
//  MarvelAPIKeyInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

protocol MarvelAPIKeyInterface {
    var keychain: MarvelKeychain? { get }
    func getMD5Hash(timeStamp: String) -> String?
}

extension MarvelAPIKeyInterface {
    
    /// MarvelAPI keys 
    var keychain: MarvelKeychain? {
        return JSONUtil.loadJson("MarvelKeychain", type: MarvelKeychain.self)
    }
    
    /// Generates a md5 hash composed by given timestamp, private and public API keys
    /// - Parameter timeStamp: timestamp
    /// - Returns: md5 hash as string value
    func getMD5Hash(timeStamp: String) -> String? {
        guard let privateKey = keychain?.privateKey, let publicKey = keychain?.publicKey else {
            return nil
        }
        return "\(timeStamp)\(privateKey)\(publicKey)".md5Hash
    }
}
