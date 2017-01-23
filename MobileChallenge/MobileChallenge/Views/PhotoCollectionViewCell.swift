//
//  PhotoCollectionViewCell.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateContent() {
        //containerView.layer.cornerRadius = 6
        self.containerView.backgroundColor = UIColor.red
        self.containerView.layer.borderColor = UIColor.black.cgColor
        self.containerView.layer.borderWidth = 2
    }
}
