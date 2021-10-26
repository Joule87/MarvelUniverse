//
//  JSONUtil.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

class JSONUtil {
    private static let logger = Logger()
    
    
    /// Loads json file and decodes its content
    /// - Parameters:
    ///   - fileName: json name file
    ///   - type: expected object type
    /// - Returns: decoded object
    static func loadJson<T: Codable>(_ fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonObject = try decoder.decode(type, from: data)
                return jsonObject
            } catch {
                logger.log(category: .repository, message: error.localizedDescription, access: .private, type: .debug)
            }
        }
        return nil
    }
}
