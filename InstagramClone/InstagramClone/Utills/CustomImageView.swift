//
//  CustomImageView.swift
//  InstagramClone
//
//  Created by vfa on 6/29/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    /// Load Image with Url
    func loadImage(urlString: String){
        print("Loading image ... ")
        
        lastURLUsedToLoadImage = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let  photoImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
        
    }
}
