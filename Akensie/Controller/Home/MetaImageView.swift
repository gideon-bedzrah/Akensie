//
//  MetaImageView.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 27/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseStorage

extension UIImageView{
    
    func loadMetaImage(from path: String) {
        
        image = UIImage(named: "IconProfile")
        
        if let imageFromCache = imageCache.object(forKey: path as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }else {
            image = UIImage(named: "IconProfile")
        }
        
        let _ = Storage.storage()
            .reference(withPath: "ProfileImage/\(path)")
            .getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                
                if let err = error {
                    print("error dowloading data: \(err)")
                }else {
            
                    guard
                        let d = data,
                        let newImage = UIImage(data: d)
                    else {
                        print("couldn't download image from \(path)")
                        return
                    }
                            
                    imageCache.setObject(newImage, forKey: path as AnyObject)
                            
                    DispatchQueue.main.async {
                        self.image = newImage
                    }
                            
                }
                
            }
    
    }
    
}
