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
    
    let photoImageView: CustomImageView = {
       let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        UIView.anchor(uiv: photoImageView, top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
