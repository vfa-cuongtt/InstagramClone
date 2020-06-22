//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by vfa on 6/8/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

protocol TabbarProtocol: class {
    func tabbarSelected(index: Int)
}

let tabIconInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

class MainTabBarController: UITabBarController {
       
    weak var tabbarDelagate: TabbarProtocol?
    var listViewController = [UIViewController]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setUpTabbar()
    }
    
    /// Set up view tabbar
    func setUpTabbar() {
        /// Background color tabbar
        self.tabBar.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        
        let layout = UICollectionViewFlowLayout()
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let addPhotoVC = AddPhotoViewController()
        let likeVC = LikeViewController()
        
        
        let userProfileVC = UserProfileController(collectionViewLayout: layout)
        
        homeVC.tabBarItem = setBarItem(title: "", selectedImage: UIImage(named: "home_selected"), normalImage: UIImage(named: "home_unselected"))
        searchVC.tabBarItem = setBarItem(title: "", selectedImage: UIImage(named: "search_selected"), normalImage: UIImage(named: "search_unselected"))
        addPhotoVC.tabBarItem = setBarItem(title: "", selectedImage: UIImage(named: "plus_selected"), normalImage: UIImage(named: "plus_unselected"))
        likeVC.tabBarItem = setBarItem(title: "", selectedImage: UIImage(named: "like_selected"), normalImage: UIImage(named: "like_unselected"))
        
        userProfileVC.tabBarItem = setBarItem(title: "", selectedImage: UIImage(named: "profile_selected"), normalImage: UIImage(named: "profile_unselected"))
        
        listViewController = [homeVC, searchVC, addPhotoVC, likeVC ,userProfileVC]
        for controller in listViewController {
            controller.tabBarItem.imageInsets = tabIconInsets
        }
        addViewControllerToTabbar(listViewController: listViewController)
    }
    
    /// Add controller to listview
    func addViewControllerToTabbar(listViewController: [UIViewController]) {
        var listNavigationController = [UIViewController]()
        
        for (_, vc) in listViewController.enumerated() {
            let nc = UINavigationController(rootViewController: vc)
            listNavigationController.append(nc)
        }
        
        self.viewControllers = listNavigationController
    }
    
    /// Create tabbar icon
    func setBarItem(title: String? = nil, selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        return item
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    /// Event when click tabbar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabbarDelagate?.tabbarSelected(index: tabBarController.selectedIndex)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            AppRouter.shared.openAddPhoto()
            return false
        } else {
            return true
        }
        
        
    }
}
