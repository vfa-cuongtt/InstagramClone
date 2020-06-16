//
//  LoginController.swift
//  InstagramClone
//
//  Created by vfa on 6/17/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
class LoginController: UIViewController {
    
    let signupButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Don't have an account? Sign Up.", for: .normal)
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(signupButton)
        
        UIView.anchor(uiv: signupButton, top: nil, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
    }
    
    @objc func handleShowSignUp()  {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
        
        
    }
}
