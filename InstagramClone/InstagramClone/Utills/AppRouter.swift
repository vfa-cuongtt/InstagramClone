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
    func openSignUp() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        AppRouter.shared.rootNavigation = nil
        let signUpVC = SignUpController()
        let navigation = UINavigationController(rootViewController: signUpVC)
        windowApp.rootViewController = navigation
    }
    
    /// Open login view controller
    func openLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        AppRouter.shared.rootNavigation = nil
        let loginVC = LoginController()
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
