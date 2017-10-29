//
//  ImageNetworking.swift
//  AppBundleReader
//
//  Created by Melody on 10/28/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func getImageFromURL(url: String) {
        let url = URL(string: url)!
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            if let data = data {
                
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data:data) {
                        imageCache.setObject(downloadedImage, forKey: url as AnyObject)
                        self.image = downloadedImage
                    }
                    
                }
            }
            else {
                print(err?.localizedDescription ?? "Error")
            }
            
        }.resume()
    }
    
}
