//
//  UserProfileController.swift
//  InstagramClone
//
//  Created by vfa on 6/8/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    let cellId = "cellId"
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        
        navigationItem.title = "User profile"
        
        fetchUser()
        setupTopHeaderProfile()
        
        // register UICollectionViewCell withReuseIdentifier: "headerId"
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        // register UICollectionViewCell forCellWithReuseIdentifier "cellId"
        collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        //Setup Logout button
        setupLogoutButton()
        
//        fetchPost()
        fetchOrderedPost()
        
    }
    
    fileprivate func setupLogoutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                AppRouter.shared.openLogin()
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr )
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    var user: User?
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            print(snapshot.value ?? "" )
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: dictionary)
            
            self.navigationItem.title = self.user?.username
            
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed fetch user:", err )
        }
    }
    
    func setupTopHeaderProfile() {
        
    }
    
    // Create header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        
        //not correct
        //        header.addSubview(UIView())
        
        return header
    }
    
}

extension UserProfileController: UICollectionViewDelegateFlowLayout {
    
    /// setup collection view with number item in section = 7
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    /// setup item
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
        
        
        cell.post = posts[indexPath.item]
        
        return cell
    }
    
    /// set inter item space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    /// set line spacing for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    /// Setup size for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with = (view.frame.width - 2) / 3
        return CGSize(width: with, height: with)
    }
    
    /// set size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width , height: 200)
    }
    
//    /// Fetch post by of user
//    fileprivate func fetchPost() {
//        print("fetch post")
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        let ref = Database.database().reference().child("post").child(uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
////            print(snapshot.value)
//            
//            guard let dictionaries = snapshot.value as? [String: Any] else { return }
//            dictionaries.forEach { (key , value) in
//                print("Key: \(key), Value: \(value)")
//                
//                guard let dictionary = value as? [String: Any] else { return }
//                let imageUrl = dictionary["imageUrl"] as? String
////                print("imageUrl___", imageUrl)
//                
//                let post = Post(dictionary: dictionary)
////                print("Post__ \(post.imageUrl)")
//                self.posts.append(post)
//            }
//            
//            self.collectionView.reloadData()
//            
//        }) { (err) in
//            print("Failed to fetch post:", err)
//        }
//    }
    
    fileprivate func fetchOrderedPost() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("post").child(uid)
        
        // perhaps later on we'll implement some pagination of data
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            print(snapshot.key, snapshot.value)
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let post = Post(dictionary: dictionary)
            self.posts.append(post)
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to fetch order post:", err)
        }
    }
}

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
}
