//
//  HomePostCell.swift
//  InstagramClone
//
//  Created by vfa on 7/1/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    var post: Post? {
        didSet {
            print(post?.imageUrl)
            guard let postImageUrl = post?.imageUrl else { return }
            
            photoImageView.loadImage(urlString: postImageUrl)
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "send2")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        
        //        label.text = " ABC test"
        
        
        
        let attributedtext = NSMutableAttributedString(string: "Username", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedtext.append(NSAttributedString(string: " Some Caption text Abc lalala hahaha hihi  hehehe", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        
        attributedtext.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 4)]))
        
        let attrOption: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.foregroundColor : UIColor.gray,
               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        
        attributedtext.append(NSAttributedString(string: "1 week ago", attributes: attrOption ))
        
        label.attributedText = attributedtext
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .gray
        
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionButton)
        addSubview(photoImageView)
        addSubview(captionLabel)
        
        UIView.anchor(uiv: userProfileImageView, top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40/2
        
        UIView.anchor(uiv: usernameLabel, top: topAnchor, bottom: photoImageView.topAnchor, left: userProfileImageView.rightAnchor, right: optionButton.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 0, height: 0)
        
        UIView.anchor(uiv: optionButton, top: topAnchor, bottom: photoImageView.topAnchor, left: nil, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 8, width: 44, height: 0)
        
        UIView.anchor(uiv: photoImageView, top: userProfileImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()
        
        UIView.anchor(uiv: captionLabel, top: likeButton.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingBottom: 0, paddingLeft: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    fileprivate func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendMessageButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        UIView.anchor(uiv: stackView, top: photoImageView.bottomAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 4 , paddingRight: 0, width: 120, height: 50)
        
        addSubview(bookmarkButton)
        UIView.anchor(uiv: bookmarkButton, top: photoImageView.bottomAnchor, bottom: nil, left: nil, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 40, height: 50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
