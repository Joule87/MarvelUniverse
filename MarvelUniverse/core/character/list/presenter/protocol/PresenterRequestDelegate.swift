//
//  PresenterRequestDelegate.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

protocol PresenterRequestDelegate: NSObject {
    func failed(errorCode: String?, errorMessage: String?)
    func succeeded()
}

protocol Requestable {
    func fetched(character: Character)
}
