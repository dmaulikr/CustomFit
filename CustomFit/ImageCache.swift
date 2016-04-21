//
//  ImageCache.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/10/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import UIKit

class ImageCache {
    static let maxMB = 5
    static let countLimit = 40
    
    static let sharedCache: NSCache = {
        let cache = NSCache()
        
        cache.name = "CustomFitImageCache"
        cache.countLimit = countLimit
        cache.totalCostLimit = maxMB*1024*1024
        
        return cache
    }()
}
