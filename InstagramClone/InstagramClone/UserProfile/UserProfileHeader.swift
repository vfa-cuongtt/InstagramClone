//
//  UserProfileHeader.swift
//  InstagramClone
//
//  Created by vfa on 6/9/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        addSubview(profileImageView)
        UIView.anchor(uiv: profileImageView, top: topAnchor, bottom: nil, left: self.leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 80, height: 80)
        
        
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.clipsToBounds = true
        
        setupProfileImage()
    }
    
    
    fileprivate func setupProfileImage() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
            Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                
                
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let username = dictionary["username"] as? String else { return }
                guard let profileImgUrl = dictionary["profileImageUrl"] as? String else { return }
                
                print("username: ", username)
                print("profileImgUrl: ", profileImgUrl)
                
                let ref = Storage.storage().reference().child(profileImgUrl)
                print("Test:", ref)
                                
                // get url for download
                ref.downloadURL { (url, err) in
                    guard let urlString = url?.absoluteString else {
                        print("Can't get url")
                        return
                    }

                    print("urlString: ", urlString)
                    
                    
                    
                    
                    guard let url = URL(string: urlString)  else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, err) in
                       // Check for error, then contruct the image using data
                        if let err = err {
                            print(" Failed to fetch profile image", err )
                            return 
                        }
                        
                        print("test: ", data)
                        guard let data = data else {return }
                        let image = UIImage(data: data)
                        
                        // need to get back onto the main UI thread
                        DispatchQueue.main.sync {
                            self.profileImageView.image = image
                        }
                        
                    }.resume()

                }
                
            
                

                
            }) { (err) in
                print("Failed fetch user:", err )
            }
        
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
