//
//  Utills.swift
//  InstagramClone
//
//  Created by vfa on 6/30/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import Foundation
import Firebase

class Utills: NSObject {
    static func getCurrentUserUid() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Cant get uid")
            return nil
        }
    
        return uid
    }
}
