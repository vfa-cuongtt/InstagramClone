//
//  SharePhotoController.swift
//  InstagramClone
//
//  Created by vfa on 6/27/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class SharePhotoController: BaseViewController {
    
    let imageView : UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        setupNavigationButton()
        
        setupImageAndTextView()
        
        
    }
    
    /// set status bar is hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }

    fileprivate func setupNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
    }
    
    fileprivate func setupImageAndTextView() {
        let containerView = UIView()
        containerView.backgroundColor = .white
            
        
        
        UIView.anchor(uiv: containerView, top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 100)
        
//        containerView.addSubview(imageView)
//        UIView.anchor(uiv: imageView, top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: nil, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 0, width: 84, height: 0)
    }
    
    @objc func handleShare() {
        print("Handle Share")
    }
}
