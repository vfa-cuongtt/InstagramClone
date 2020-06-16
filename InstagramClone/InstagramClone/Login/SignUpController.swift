//
//  SignUpController.swift
//  InstagramClone
//
//  Created by vfa on 6/2/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    let btnAddPhoto: UIButton = {
        let button = UIButton(type: .system)
        
        // Setting auto layout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        //Add action
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        //Add action
        tf.addTarget(self, action: #selector(handleTextFieldInputChange), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        //Add action
        tf.addTarget(self, action: #selector(handleTextFieldInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        //Add action
        tf.addTarget(self, action: #selector(handleTextFieldInputChange), for: .editingChanged)
        
        
        return tf
    }()
    
    let signUpButton: UIButton = {
        
        let btn = UIButton(type: .system ) // (type: .system) => can tap button
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = false
        
        // Add action
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnAddPhoto)
        
        // add active for constraint
        btnAddPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        btnAddPhoto.anchor(top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 40, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 140, height: 140)
        
        UIView.anchor(uiv: btnAddPhoto, top: view.topAnchor, bottom: nil, left: nil, right: nil, paddingTop: 40, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 140, height: 140)
        setupInputField()
    }
    
    // hidden Navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupInputField() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        
        // phan chia cac  field
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
        
        // add active for constraint
        //        stackView.anchor(top: btnAddPhoto.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 40, paddingRight: 40, width: 0, height: 200)
        UIView.anchor(uiv: stackView, top: btnAddPhoto.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 40, paddingRight: 40, width: 0, height: 200)
        
    }
    
    @objc func handleSignUp() {
        print(" test ")
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user", err)
                return
            }
            
            guard let image = self.btnAddPhoto.imageView?.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference()
            
            storageRef.child("profile_image").child(filename).putData(uploadData, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Failed to upload profile image:", err )
                    return
                }
                print("CuongTT_", metadata)
                
                guard let urlString = metadata?.path as? String else {
                    print(" Can't get urlstring")
                    return
                }
                
                print("AAAAAA__", urlString)
                
                /// khi upload file thì nên luu lại public URL. và luu trên firebase
                /// Mục đích để sau này khi cần thì download trực tiếp luôn không cần phải parse URI. ->  URL
                storageRef.child(urlString).downloadURL { (url, err) in
                    guard let urlAvartar = url?.absoluteString else {
                        print("Can't get url")
                        return
                    }
                    
                    print("Successfully uploaded profile image: ", urlAvartar)
                    guard let uid = user?.user.uid else { return }
                    let dictionaryValues = ["username": username, "profileImageUrl": urlAvartar]
                    let values = [uid: dictionaryValues]
                    Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                        if let err = err {
                            print("Failed to save user info into db:", err)
                            return
                        }
                        
                        print("Successfully saved user info into db")
                    }
                    
                }
                
                // Test source
                //                guard let profileImageUrl = metadata?.path else {
                //                    print("Can't get profile image url")
                //                    return
                //                }
                //
                //                print("Successfully uploaded profile image", profileImageUrl )
                //
                //                guard let uid = user?.user.uid else { return }
                //                let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl]
                //                let values = [uid: dictionaryValues]
                //                Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                //                    if let err = err {
                //                        print("Failed to save user info into db:", err)
                //                        return
                //                    }
                //
                //                    print("Successfully saved user info into db")
                //                }
                
                
            }
            
            
        }
    }
    
    @objc func handleTextFieldInputChange() {
        guard let email = emailTextField.text, !email.isEmpty, let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 255)
            signUpButton.isEnabled = false
            return
        }
        
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        signUpButton.isEnabled = true
    }
    
    @objc func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            btnAddPhoto.setImage(editImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            btnAddPhoto.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        btnAddPhoto.layer.cornerRadius = btnAddPhoto.frame.width/2
        btnAddPhoto.layer.masksToBounds = true
        btnAddPhoto.layer.borderColor = UIColor.black.cgColor
        btnAddPhoto.layer.borderWidth = 2
        
        
        dismiss(animated: true, completion: nil )
    }
}


