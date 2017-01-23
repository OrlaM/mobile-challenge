//
//  FullScreenPhotoViewController.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    var photoID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let service = PhotoService()
        
        service.getPhotos(photoURL: .getPopularPhotoList) { (photoList) in
//            self.photoList = photoList
//            DispatchQueue.main.sync {
//                self.photoCollectionView.reloadData()
//            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //photoCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FullScreenPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as? FullScreenPhotoCollectionViewCell else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath)
            return cell
        }
        
       // photoCell.updateContent(photoList.photos[indexPath.row])
        
        return photoCell
    }
    
}
