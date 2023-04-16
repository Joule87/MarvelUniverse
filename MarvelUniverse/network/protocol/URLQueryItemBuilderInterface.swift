//
//  URLQueryItemBuilderInterface.swift
//  MarvelUniverse
//
//  Created by Julio Collado Perez on 4/16/23.
//

import Foundation

protocol URLQueryItemBuilderInterface {
    var defaultURLQueryItems: [URLQueryItem] { get }
    func getURLQueryItems(for offSet: Int?, limit: Int?) -> [URLQueryItem]
}
