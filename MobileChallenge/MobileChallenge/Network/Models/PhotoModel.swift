//
//  PhotoModel.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import Foundation

class PhotoModel {
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var timesViews: Int = 0
    var rating: Double = 0
    var createdAt: Date?
    var category: Int = 0
    var privacy: Bool = false
    var width: Int = 0
    var height: Int = 0
    var votesCount: Int = 0
    var commentsCount: Int = 0
    var nsfw: Bool?
    var thumnailURL: String?
    var imageURL: String?
    var user: Dictionary<String,Any>?
    
}
