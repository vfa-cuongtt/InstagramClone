//
//  AppDelegate.swift
//  InstagramClone
//
//  Created by vfa on 6/2/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // setting Firebase
        FirebaseApp.configure()
        
        self.openWindows()
        return true
    }
    
    /// Handle open Windows root
    private func openWindows() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser == nil {
            print("Current User", Auth.auth().currentUser)
            AppRouter.shared.openLogin()
        } else {
            print("Current User", Auth.auth().currentUser)
            AppRouter.shared.openHome()
        }
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
