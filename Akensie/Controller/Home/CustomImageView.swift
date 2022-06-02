//
//  CustomImageView.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 19/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

protocol setBackbackground {
    func changeColor()
}

extension UIImageView {
    
    static var task: URLSessionDataTask!
   static var changeDelegate: setBackbackground?
    
    
    func loadImage(from url: URL) {
//        image = nil
        
//
//        if let task = UIImageView.task {
//            task.cancel()
//        }
//
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            UIImageView.changeDelegate?.changeColor()
            
            return
        }
        else {
            image = UIImage(named: "NoLoadScreen")
        }
        
        UIImageView.task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            UIImageView.changeDelegate?.changeColor()
            
            if let err = error {
                print("error loading request: \(err)")
            }else{
                
                guard
                    let d = data,
                    let newImage = UIImage(data: d)
                else {
                    print("couldn't download image from \(url)")
                    return
                }
                
                imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
                
                
                DispatchQueue.main.async {
                    self.image = newImage
                    UIImageView.changeDelegate?.changeColor()
                }
            }
        }
        
        UIImageView.task.resume()
    }    
}
