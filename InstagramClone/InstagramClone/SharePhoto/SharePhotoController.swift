//
//  SharePhotoController.swift
//  InstagramClone
//
//  Created by vfa on 6/27/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: BaseViewController {
    let storageRef = Storage.storage().reference()
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdatedFeed")
    var selectedImage: UIImage? {
        didSet{
            self.imageView.image = selectedImage
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
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
        
        
        view.addSubview(containerView)
        UIView.anchor(uiv: containerView, top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        UIView.anchor(uiv: imageView, top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, right: nil, paddingTop: 8, paddingBottom: -8, paddingLeft: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        UIView.anchor(uiv: textView, top: containerView.topAnchor, bottom: containerView.bottomAnchor, left: imageView.rightAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 4, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare() {
        guard let caption = textView.text, !caption.isEmpty else { return }
        guard let image = selectedImage else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        storageRef.child("post").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to podt image:", err)
                return
            }
            
            
            guard let urlString = metadata?.path as? String else {
                print(" Can't get urlstring")
                return
            }
            print("Successfully uploaded post image:", urlString)
            
            self.storageRef.child(urlString).downloadURL { (url, err) in
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to download url")
                    return
                }
                
                print("URL", url )
                
                guard let imageUrl = url?.absoluteString else {
                    print("Can't get url")
                    return
                }
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
            }
            
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard  let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("post").child(uid)
        let ref = userPostRef.childByAutoId()
        let creationDate = Date().timeIntervalSince1970
        let imageWidth = postImage.size.width
        let imageHeight = postImage.size.height
        
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": imageWidth, "imageHeight": imageHeight, "creationDate": creationDate] as [String : Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to DB", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
                return
            }
        }
        
        print("Success to save post to DB", ref)
//        self.dismiss(animated: true, completion: nil)
        AppRouter.shared.openHome()
        
        NotificationCenter.default.post(name: SharePhotoController.updateFeedNotificationName, object: nil)
    }
}
