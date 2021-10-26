//
//  ImageDownloader.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

struct ImageDownloader: Downloadable {
    
    var networkManager: NetworkManagerInterface = NetworkManager()
    
    func fetch(from urlSting: String, completion: ((Data?) -> Void)? = nil) {
        guard let url = URL(string: urlSting) else {
            completion?(nil)
            return
        }
        
        if let imageFromCache = imageDataCache.object(forKey: urlSting as AnyObject), let data = imageFromCache as? Data {
            completion?(data)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            networkManager.fetchData(from: url) { result in
                switch result {
                case .success(let data):
                    imageDataCache.setObject(data as AnyObject, forKey: urlSting as AnyObject)
                    completion?(data)
                case .failure(_):
                    completion?(nil)
                }
            }
        }
    }
}
