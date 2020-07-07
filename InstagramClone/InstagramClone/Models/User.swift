//
//  User.swift
//  InstagramClone
//
//  Created by vfa on 7/7/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
    }
}
