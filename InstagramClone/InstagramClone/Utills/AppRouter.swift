//
//  AppRouter.swift
//  InstagramClone
//
//  Created by vfa on 6/8/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    var rootNavigation: UINavigationController?
    
    /// Navigation root is Login flow
    func openLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        AppRouter.shared.rootNavigation = nil
//        let loginVC = ViewController()
        let loginVC = SignUpController()
        let navigation = UINavigationController(rootViewController: loginVC)
        windowApp.rootViewController = navigation
    }
    
    /// Navigation root is TabBar flow
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        let tabBar = MainTabBarController()
        windowApp.rootViewController = tabBar
    }
}
