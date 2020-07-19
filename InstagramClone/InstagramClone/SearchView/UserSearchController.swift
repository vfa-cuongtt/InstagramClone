//
//  UserSearchController.swift
//  InstagramClone
//
//  Created by vfa on 6/22/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Firebase

class UserSearchController: UICollectionViewController {
    let cellId = "cellId"
    var users = [User]()
    var filteredUsers = [User]()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter username"
        sb.barTintColor = .gray
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.addSubview(searchBar)
        let navBar = navigationController?.navigationBar
        
        UIView.anchor(uiv: searchBar, top: navBar?.topAnchor, bottom: navBar?.bottomAnchor, left: navBar?.leftAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 8, width: 0, height: 0)
        
        collectionView.register(UserSearchCell.self , forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
        
        fetchUsers()
    }
    
    fileprivate func  fetchUsers(){
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any]
                else {return}
            dictionaries.forEach { (key, value) in
                guard let userDictionary = value as? [String: Any] else { return }
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
                print(user.uid, user.username)
            }
            
            // Sort users by A-Z a-z
            self.users.sort { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            }
            
            self.filteredUsers = self.users
            self.collectionView.reloadData()
        }) { (err) in
            print( "Failed to fetch users for search ", err )
        }
    }
    
    // input text auto Search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            self.filteredUsers = self.users.filter({ (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            })
        }
        
        
        
        self.collectionView.reloadData()
    }

   
}

extension UserSearchController: UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserSearchCell
        
         
        cell.user = filteredUsers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
}
