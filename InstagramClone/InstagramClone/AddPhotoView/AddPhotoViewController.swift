//
//  AdPhotoViewController.swift
//  InstagramClone
//
//  Created by vfa on 6/22/20.
//  Copyright © 2020 Tuan Cuong. All rights reserved.
//

import UIKit
import Photos

class AddPhotoViewController: UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    var arrImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .yellow
        
        setupNavigationButons()
        
        collectionView.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchPhotos()
    }
    
    /// fetching photo in image library
    fileprivate func fetchPhotos() {
        print("fetching photo")
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let sortDesc = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDesc]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        allPhotos.enumerateObjects { (asset, count, stop) in
            print("Test Asset", asset)
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                print("Image_", image)
                if let image = image {
                    self.arrImages.append(image)
                }
                
                if count == allPhotos.count - 1 {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    fileprivate func setupNavigationButons()  {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    @objc func handleNext() {
        print("handleNext")
        
    }
    
    @objc func handleCancel() {
        print("handleCancel")
        AppRouter.shared.openHome()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension AddPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        
        /// get img add to cell
        cell.photoImageView.image = arrImages[indexPath.item]
        
        return cell
    }
    
    /// Set size for item 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    /// set line spacing for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
        
    }
    /// set inter item space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    /// set spacing for header and colection item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    
    // Set size for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        header.backgroundColor = .red
        return header
    }
}
