//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by vfa on 6/8/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController {
    
    let cellId = "cellId"
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        collectionView.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationItems()
        
        fetchPost()
        
        fetchFollowingUserIds()
        
    }
    
    fileprivate func fetchFollowingUserIds() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value) { (snapshot ) in
            print(snapshot.value)
            
            guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
            userIdsDictionary.forEach { (key, value) in
                Database.fetchUserWithUID(uid: key) { (user) in
                    self.fetchPostWithUser(user: user)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        
        
        return cell
    }
    
    func setupNavigationItems() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo2"))
    }
    
    /// Fetch post by of user
    fileprivate func fetchPost() {
        print("fetch post")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Call func fetchUserWithUID in custom extension Firebase
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchPostWithUser(user: user)
        }

    }
    
    /// Fetch Post With User
    fileprivate func fetchPostWithUser(user: User) {
        /// get dictionary child key in  post of current user
        let uid = user.uid
        let ref = Database.database().reference().child("post").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            dictionaries.forEach { (key , value) in
                print("Key: \(key), Value: \(value)")
                
                guard let dictionary = value as? [String: Any] else { return }
                
                
                let post = Post(user: user, dictionary: dictionary)
                
                
                self.posts.append(post)
            }
            
            // Sort Post new feeds
            self.posts.sort { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            }
            
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to fetch post:", err)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 40 is height userProfileImageView
        /// 8 is top and bottom is userProfileImageView
        
        var height: CGFloat = 40 + 8 + 8 // username userProfileImageView
        height += view.frame.width
        height += 50 // 50 is height of stackView
        height += 80 // 120 is height of captionLabel
        
        return CGSize(width: view.frame.width, height: height)
    }
}

