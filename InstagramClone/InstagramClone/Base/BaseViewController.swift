//
//  BaseViewController.swift
//  InstagramClone
//
//  Created by vfa on 6/18/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// Show Navigation bar
    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    /// Hiden Navigation bar
    func hidenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    /// Hiden back button bar
    func hidenBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    /// Hiden back button bar
    func showBackButton() {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    /// Set  text corlor for navigation bar
    func setTextColorForNavigationBar() {
        // change navigation bar style is white
        self.navigationController?.navigationBar.barStyle = .black
    }
}
