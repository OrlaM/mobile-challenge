//
//  FullScreenPhotoViewController.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    var currentPhotoIndex = 0
    var photoList = PhotoListModel()
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        photoCollectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        let indexPath = IndexPath(row: currentPhotoIndex, section: 0)
        photoCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
}

extension FullScreenPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath) as? FullScreenPhotoCollectionViewCell else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenCell", for: indexPath)
            return cell
        }
        
        photoCell.updateContent(photoList.photos[indexPath.row])
        
        return photoCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width;
        currentPhotoIndex = Int(scrollView.contentOffset.x / pageWidth);
    }
}
