//
//  PhotoService.swift
//  MobileChallenge
//
//  Created by Orla on 23/01/2017.
//  Copyright © 2017 500px. All rights reserved.
//

import Foundation

class PhotoService {
    
    static let thumnailQuality = 3
    static let fullQuality = 1080
    static let catagoryToExclude = 4
    
    let baseURL = "https://api.500px.com/v1/photos?"
    let consumerKey = "consumer_key=LrkHj1j2PydlgEdRgtEl30DQhFjIUPM4yHbSwHAb"
    let quality = "image_size=\(thumnailQuality),\(fullQuality)&"
    let exclude = "exclude=\(catagoryToExclude)&"
    let feature = "feature=popular&"
        
    func getPhotos(_ completion: @escaping (_ result: PhotoListModel) -> Void) {
        
        guard let url = URL(string: baseURL + feature + exclude + quality + consumerKey) else {
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        let task = session.dataTask(with: request) { (data,response,error) in
            guard let data = data else {
                print("Something went wrong")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let photoData = json as? [String: Any] else {
                print("Something went wrong")
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
                print("Something went wrong")
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
                
                guard let imageURLs = photoDict["images"] as? [Dictionary<String,Any>] else {
                    photo.imageURL = photoDict["image_url"] as? String
                    photo.thumnailURL = photoDict["image_url"] as? String
                    photoList.photos.append(photo)
                    return
                }
                
                for imageURL in imageURLs {
                    let size = imageURL["size"] as? Int ?? 0
                    
                    if size == PhotoService.thumnailQuality {
                        photo.thumnailURL = imageURL["url"] as? String
                    }
                    else if size == PhotoService.fullQuality {
                        photo.imageURL = imageURL["url"] as? String
                    }
                }
                
                photoList.photos.append(photo)
            }
            
            completion(photoList)
        }
        
        task.resume()
    }
    
}
