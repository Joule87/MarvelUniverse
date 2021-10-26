//
//  String+Extension.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation
import CryptoKit

extension String {
    var md5Hash: String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
