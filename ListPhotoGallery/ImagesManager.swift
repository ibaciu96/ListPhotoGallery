//
//  ImagesManager.swift
//  ListPhotoGallery
//
//  Created by Ionut Baciu on 27/07/2018.
//  Copyright © 2018 Ionut Baciu. All rights reserved.
//

import UIKit
import Foundation

class ImagesManager {
    private let maxSize = 6
    private var imageCache = [String : UIImage]()
    private var adjust = [Int : String]()
    private var count = 0
    
    func addToCache(put image: UIImage, with name: String) {
        if imageCache.count >= maxSize {
            let (key, value) = adjust.min(by: { $0.key < $1.key })!
            adjust[key] = nil
            imageCache[value] = nil
        }
        imageCache[name] = image
        adjust[count] = name
        count += 1
    }
    
    func getFromCache(with name: String) -> UIImage? {
        return imageCache[name]
    }
    
    func getCacheSize() -> Int {
        return imageCache.count
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(imageCache, forKey: "cache")
        defaults.set(adjust, forKey: "adjust")
        defaults.set(count, forKey: "state")
    }
    
    func get() {
        let defaults = UserDefaults.standard
        if let cache = defaults.object(forKey: "cache") as? [String : UIImage],
            let adj = defaults.object(forKey: "adjust") as? [Int : String],
            let cnt = defaults.object(forKey: "state") as? Int {
            imageCache = cache
            adjust = adj
            count = cnt
        }
    }
}
