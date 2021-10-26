//
//  MarvelAPIKeyManager.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

protocol MarvelAPIKeyManager {
    var keychain: MarvelKeychain? { get }
    func getMD5Hash(timeStamp: String) -> String?
}

extension MarvelAPIKeyManager {
    var keychain: MarvelKeychain? {
        return JSONUtil.loadJson("MarvelKeychain", type: MarvelKeychain.self)
    }
    
    func getMD5Hash(timeStamp: String) -> String? {
        guard let privateKey = keychain?.privateKey, let publicKey = keychain?.publicKey else {
            return nil
        }
        return "\(timeStamp)\(privateKey)\(publicKey)".md5Hash
    }
}
