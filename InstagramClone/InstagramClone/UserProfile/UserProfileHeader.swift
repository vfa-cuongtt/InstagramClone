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
    var user:User? {
        didSet{
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            lblUsername.text = user?.username
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        
        return iv
    }()
    
    let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "grid"), for: .normal)
        
        return btn
    }()
    
    let listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        return btn
    }()
    
    let lblUsername: UILabel = {
        let lb = UILabel()
        lb.text = "Username"
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        return lb
    }()
    
    let lblPost: UILabel = {
        let lb = UILabel()
        
        // setup stats value: Posts
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        let attrLabelPosts: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        attributedText.append(NSAttributedString(string: "posts", attributes: attrLabelPosts))
        
        lb.attributedText = attributedText
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    let lblFollowers: UILabel = {
        let lb = UILabel()
        
        // setup stats value: Followers
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        let attrLabelPosts: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        attributedText.append(NSAttributedString(string: "follower", attributes: attrLabelPosts))
        
        lb.attributedText = attributedText
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb 
    }()
    
    let lblFollowing: UILabel = {
        let lb = UILabel()
        
        // setup stats value: Following
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        let attrLabelPosts: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        attributedText.append(NSAttributedString(string: "follwing", attributes: attrLabelPosts))
        
        lb.attributedText = attributedText
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        UIView.anchor(uiv: profileImageView, top: topAnchor, bottom: nil, left: self.leftAnchor, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 0, width: 80, height: 80)
        
        
        profileImageView.layer.cornerRadius = 80/2
        profileImageView.clipsToBounds = true
        
        setupBottomToobar()
        addSubview(lblUsername)
        UIView.anchor(uiv: lblUsername, top: profileImageView.bottomAnchor, bottom: gridButton.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
    }
    
    /// Setup stats view
    /// Post, Follower, Following
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [lblPost,lblFollowers,lblFollowing])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        // add
        addSubview(stackView)
        UIView.anchor(uiv: stackView, top: topAnchor, bottom: nil, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
        
        //add Edit profile button
        addSubview(editProfileButton)
        UIView.anchor(uiv: editProfileButton, top: lblPost.bottomAnchor, bottom: nil, left: lblPost.leftAnchor, right: lblFollowing.rightAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 34)
    }
    
    /// Setup bottom toolbar
    fileprivate func setupBottomToobar() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        UIView.anchor(uiv: stackView, top: nil, bottom: self.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        
        UIView.anchor(uiv: topDividerView, top: stackView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
        
        UIView.anchor(uiv: bottomDividerView, top: stackView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
    
    
    
//    /// Setup profile image
//    fileprivate func setupProfileImage() {
//        print("Did set \(user?.username)")
//        guard let profileImgUrl = user?.profileImageUrl else {return}
//        guard let url = URL(string: profileImgUrl)  else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            // Check for error, then contruct the image using data
//            if let err = err {
//                print(" Failed to fetch profile image", err )
//                return
//            }
//            
//            print("test: ", data)
//            guard let data = data else {return }
//            let image = UIImage(data: data)
//            
//            // need to get back onto the main UI thread
//            DispatchQueue.main.sync {
//                self.profileImageView.image = image
//            }
//            
//        }.resume()
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
