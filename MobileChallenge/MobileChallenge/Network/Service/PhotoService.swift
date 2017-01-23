//
//  PhotoService.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import Foundation

class PhotoService {
    
    static let baseURL = "https://api.500px.com/v1/"
    static let consumerKey = "consumer_key=LrkHj1j2PydlgEdRgtEl30DQhFjIUPM4yHbSwHAb"
    static let thumnailQuality = 3
    static let fullQuality = 1080
    
    enum PhotoURL {
        
        case getPopularPhotoList
        case getIndividualPhoto(id:Int)
        
        public var quality: String {
            switch self {
            case .getPopularPhotoList:
                return "image_size=\(thumnailQuality)&"
            case .getIndividualPhoto:
                return "image_size=\(fullQuality)&"
            }
        }
        public var method: String {
            switch self {
            case .getPopularPhotoList,
                 .getIndividualPhoto:
                return "GET"
            }
        }
        
        public var path: String {
            switch self {
            case .getPopularPhotoList:
                return baseURL + "photos?feature=popular&" + quality + consumerKey
            case .getIndividualPhoto(let photoID):
                return baseURL + "photos/\(photoID)?" + quality + consumerKey
            }
        }
    
    }
    
    func getPhotos(photoURL: PhotoURL, _ completion: @escaping (_ result: PhotoListModel) -> Void) {
        
        guard let url = URL(string: photoURL.path) else {
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = photoURL.method
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        // TODO: Add error handling
        let task = session.dataTask(with: request) { (data,response,error) in
            guard let data = data else {
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let photoData = json as? [String: Any] else {
                return
            }
            
            let photoList = PhotoListModel()
            photoList.feature = photoData["feature"] as? String ?? ""
            photoList.currentPage = photoData["current_page"] as? Int ?? 0
            photoList.totalPages = photoData["total_pages"] as? Int ?? 0
            photoList.totalItems = photoData["total_items"] as? Int ?? 0
            
            if let filters = photoData["filters"] as? [String:Bool] {
                photoList.filters = filters
            }
            
            guard let photos = photoData["photos"] as? Array<Dictionary<String, Any>> else {
                return
            }
            
            for photoDict in photos {
                let photo = PhotoModel()
                photo.id = photoDict["id"] as? Int ?? 0
                photo.name = photoDict["name"] as? String ?? ""
                photo.description = photoDict["description"] as? String ?? ""
                photo.timesViews = photoDict["times_viewed"] as? Int ?? 0
                photo.rating = photoDict["rating"] as? Double ?? 0
                photo.category = photoDict["category"] as? Int ?? 0
                photo.privacy = photoDict["privacy"] as? Bool ?? false
                photo.width = photoDict["width"] as? Int ?? 0
                photo.height = photoDict["height"] as? Int ?? 0
                photo.votesCount = photoDict["votes_count"] as? Int ?? 0
                photo.commentsCount = photoDict["comments_count"] as? Int ?? 0
                photo.nsfw = photoDict["nsfw"] as? Bool
                photo.imageURL = photoDict["image_url"] as? String
                
                photoList.photos.append(photo)
            }
            
            completion(photoList)
        }
        
        task.resume()
    }
    
}
