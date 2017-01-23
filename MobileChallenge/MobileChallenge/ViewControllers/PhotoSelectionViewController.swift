//
//  PhotoSelectionViewController.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit

class PhotoSelectionViewController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoList = PhotoListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = PhotoService()
        
        service.getPhotos() { (photoList) in
            self.photoList = photoList
            DispatchQueue.main.sync {
                self.photoCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        photoCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PhotoSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width/3.0
        return CGSize(width: width, height: width*0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ThumnailPhotoCollectionViewCell else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }
        
        photoCell.updateContent(photoList.photos[indexPath.row])

        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "FullScreenPhotoViewController") as? FullScreenPhotoViewController {
            
            vc.photoList = self.photoList
            vc.currentPhotoIndex = indexPath.row
            self.show(vc, sender: self)
        }
        
    }
    
}
