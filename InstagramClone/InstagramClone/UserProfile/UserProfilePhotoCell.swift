//
//  UserProfilePhotoCell.swift
//  InstagramClone
//
//  Created by vfa on 6/29/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    /// get image data  of  Post Model add for cell
    var post: Post? {
        didSet{
            print("AAAAA__", post?.imageUrl)
            
            guard let imageUrl = post?.imageUrl else { return }
            photoImageView.loadImage(urlString: imageUrl)
            
        }
    }
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
//        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
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
