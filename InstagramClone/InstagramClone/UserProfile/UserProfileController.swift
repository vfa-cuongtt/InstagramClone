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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .lightGray
        
        navigationItem.title = "User profile"
        
        fetchUser()
        setupTopHeaderProfile()
        
        // register UICollectionViewCell withReuseIdentifier: "headerId"
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
    }

    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            print(snapshot.value)
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let username = dictionary["username"] as? String
            self.navigationItem.title = username
            
//            snapshot.dictionaryWithValues(forKeys: <#T##[String]#>)
        }) { (err) in
            print("Failed fetch user:", err )
        }
    }
    
    func setupTopHeaderProfile() {
        
    }
    
    // Create header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        
        //not correct
//        header.addSubview(UIView())
                
        return header
    }

    
    

}

extension UserProfileController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: self.view.frame.width , height: 200)
        }
}
