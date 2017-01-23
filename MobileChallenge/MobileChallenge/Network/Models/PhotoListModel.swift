//
//  PhotoListModel.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import Foundation

class PhotoListModel {
    
    var feature: String = ""
    var filters = Dictionary<String,Bool>()
    var currentPage: Int = 0
    var totalPages: Int = 0
    var totalItems: Int = 0
    var photos = Array<PhotoModel>()
    
}
