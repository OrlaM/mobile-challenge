//
//  PhotoCollectionViewCell.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit
import SDWebImage

class ThumnailPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateContent(_ photoData: PhotoModel) {
        
        guard let imageURL = photoData.thumnailURL else {
            print("Something went wrong")
            photoImageView.image = UIImage(named: "placeholder")
            return
        }

        guard let url = URL(string: imageURL) else {
            print("Something went wrong")
            photoImageView.image = UIImage(named: "placeholder")
            return
        }
        
        photoImageView.sd_setImage(with: url)
    }
}
