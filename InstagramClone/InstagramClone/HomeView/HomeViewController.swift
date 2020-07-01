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
        
        let ref = Database.database().reference().child("post").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            //            print(snapshot.value)
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            dictionaries.forEach { (key , value) in
                print("Key: \(key), Value: \(value)")
                
                guard let dictionary = value as? [String: Any] else { return }
                let imageUrl = dictionary["imageUrl"] as? String
                //                print("imageUrl___", imageUrl)
                
                let post = Post(dictionary: dictionary)
                //                print("Post__ \(post.imageUrl)")
                self.posts.append(post)
            }
            
            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to fetch post:", err)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
