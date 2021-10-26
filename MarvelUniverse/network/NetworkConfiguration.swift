//
//  NetworkConfiguration.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 20/10/21.
//

import Foundation

struct NetworkConfiguration {
    static var baseUrl: String? {
        guard let path = Bundle.main.path(forResource: ConstantFileName.INFO, ofType: ConstantFileType.PLIST),
              let infoDictionary = NSDictionary(contentsOfFile: path),
              let serverURL = infoDictionary[ConstantNetwork.SERVER_URL] as? String else {
            return nil
        }
        return serverURL
    }
}
