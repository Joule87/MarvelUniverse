//
//  Downloadable.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

protocol Downloadable {
    /// Download image from given urlString and cache it using urlString as a key.
    /// - Parameters:
    ///   - urlSting: String URL
    ///   - completion: A block object to be executed over fetched data.
    func fetch(from urlSting: String, completion: ((Data?) -> Void)?)
}
