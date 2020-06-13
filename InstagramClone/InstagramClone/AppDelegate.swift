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
        // Override point for customization after application launch.
        
        // setting Firebase
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        AppRouter.shared.openHome()
//        AppRouter.shared.openLogin()
//        window?.rootViewController = ViewController() //MainTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func goToHome() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController() //MainTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    func goToLogin() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController() //MainTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
