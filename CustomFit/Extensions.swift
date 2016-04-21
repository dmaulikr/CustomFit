//
//  Extensions.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/10/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import UIKit

extension NSURL {
    func getCachedImage() -> UIImage? {
        return ImageCache.sharedCache.objectForKey(absoluteString) as? UIImage
    }
    
    func fetchImage(completion:(image: UIImage) -> Void) {
        NSURLSession.sharedSession().dataTaskWithURL(self) {
            data, response, error in
            if error == nil {
                if let data = data, image = UIImage(data: data) {
                    ImageCache.sharedCache.setObject(image, forKey: self.absoluteString, cost: data.length)
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(image: image)
                    }
                }
            }
        }.resume()
    }
}

extension NSURLComponents {
    func getQueryItem(name: String) -> NSURLQueryItem? {
        guard let queryItems = queryItems else {
            return nil
        }
        
        for queryItem in queryItems {
            if queryItem.name == name {
                return queryItem
            }
        }
        
        return nil
    }
}
