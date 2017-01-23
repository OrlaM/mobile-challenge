//
//  FullScreenPhotoViewCell.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import UIKit
import SDWebImage

class FullScreenPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateContent(_ photoData: PhotoModel) {
        
        guard let imageURL = photoData.imageURL else {
            return // TODO: Error condition
        }
        
        guard let url = URL(string: imageURL) else {
            return // TODO: Error condition
        }
        
        photoImageView.sd_setImage(with: url)
        
        // Update image constraints
        imageAspectRatioConstraint = imageAspectRatioConstraint.setMultiplier(multiplier: CGFloat(photoData.width)/CGFloat(photoData.height))

        if containerView.frame.width < containerView.frame.height {
            imageWidthConstraint.constant = containerView.frame.width
            imageHeightConstraint.constant = containerView.frame.width
        }
        else {
            imageWidthConstraint.constant = containerView.frame.height
            imageHeightConstraint.constant = containerView.frame.height
        }
        
        if photoData.height > photoData.width {
            imageHeightConstraint.priority = 950
            imageWidthConstraint.priority = 900
        }
        
        self.containerView.layoutIfNeeded()
    }
}
