 //
 //  PhotoSelectorHeader.swift
 //  InstagramClone
 //
 //  Created by vfa on 6/26/20.
 //  Copyright © 2020 Tuan Cuong. All rights reserved.
 //
 
 import UIKit
 
 class PhotoSelectorHeader: UICollectionViewCell {
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .cyan
        
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
