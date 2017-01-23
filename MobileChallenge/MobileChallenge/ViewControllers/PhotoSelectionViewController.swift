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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = PhotoService()
        
        service.getPhotos(photoURL: .getPopularPhotoList) { (photoList) in
            print(photoList)
        }
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 10)/3.0
        return CGSize(width: width, height: width*0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoCollectionViewCell else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            return cell
        }
        
        photoCell.updateContent()

        return photoCell
    }
    
}
