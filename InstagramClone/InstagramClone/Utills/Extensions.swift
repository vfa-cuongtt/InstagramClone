//
//  Extensions.swift
//  InstagramClone
//
//  Created by vfa on 6/2/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    static func anchor(uiv: UIView, top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) -> Void {
    
        // Set Auto layout for textField
        uiv.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            uiv.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            uiv.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let left = left {
            uiv.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
             
            uiv.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            uiv.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            uiv.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

//func getCurrentUserUid() -> String {
//    guard let uid = Auth.auth().currentUser?.uid else {
//        print("Cant get uid")
//        return ""
//    }
//    
//    return uid
//}
