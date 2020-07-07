//
//  FirebaseUtills.swift
//  InstagramClone
//
//  Created by vfa on 7/7/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> Void) {
        print("Test UID", uid)
        
        /// get dictionary child key in  users of current user
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let userDictionary = snapshot.value as? [String: Any] else { return }

            let user = User(uid: uid, dictionary: userDictionary)

            print("user name", user.username)
            
            completion(user)

        }) { (err) in
            print("Failed to fetch posts ")

        }
    }
}
