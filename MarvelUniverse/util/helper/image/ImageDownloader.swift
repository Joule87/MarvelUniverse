//
//  ImageDownloader.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation

let imageDataCache = NSCache<NSString, AnyObject>()

struct ImageDownloader: Downloadable {
    
    var networkManager: NetworkManagerInterface
    
    init(networkManager: NetworkManagerInterface = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetch(from urlSting: String, completion: ((Data?) -> Void)? = nil) {
        guard let url = URL(string: urlSting) else {
            completion?(nil)
            return
        }
        
        if let imageFromCache = imageDataCache.object(forKey: NSString(string: urlSting)), let data = imageFromCache as? Data {
            completion?(data)
            return
        }
        
        networkManager.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                imageDataCache.setObject(data as AnyObject, forKey: NSString(string: urlSting))
                completion?(data)
            case .failure(_):
                completion?(nil)
            }
        }
    }
}
