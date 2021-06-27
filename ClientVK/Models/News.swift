//
//  News.swift
//  ClientVK
//
//  Created by Denis Molkov on 31.05.2021.
//

import Foundation


class NewsItem {
    var sourceId = 0
    var date = ""
    var text = ""
    var attachments: [NewsItemAttachments] = []
    var comments = 0
    var likes = 0
    var reposts = 0
    var photos: [String] = []
    var startTime = ""
    var aspectRatio = 1.0
    
    init(json: [String: Any]) {
        self.sourceId = json["source_id"] as! Int
        
        if let dateJson = json["date"] as? Int {
            self.startTime = String(dateJson + 1)
            let date = Date(timeIntervalSince1970: TimeInterval(dateJson))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm, d MMM y"
            self.date = dateFormatter.string(from: date)
        }
        
        if let text = json["text"] as? String {
            self.text = text
        }
        
        if let attachmentsJson = json["attachments"] as? [[String: Any]] {
            self.attachments = attachmentsJson.map { NewsItemAttachments(json: $0) }
        }
        
        if let commentsJson = json["comments"] as? [String: Any] {
            self.comments = commentsJson["count"] as! Int
        }
        
        let likesJson = json["likes"] as! [String: Any]
        self.likes = likesJson["count"] as! Int
        
        let repostsJson = json["reposts"] as! [String: Any]
        self.reposts = repostsJson["count"] as! Int
        
        self.attachments.forEach { attachment in
            guard let photo = attachment.photo else {
                return
            }
            
            self.aspectRatio = (photo.height ?? 1.0) / (photo.width ?? 1.0)
            
            if photo.photo807 != "" {
                self.photos.append(photo.photo807)
            } else if photo.photo604 != "" {
                self.photos.append(photo.photo604)
            } else if photo.photo130 != "" {
                self.photos.append(photo.photo130)
            }
        }
    }
}

class NewsItemAttachments {
    var type = ""
    var photo: NewItemAttachmentsPhoto?
    
    init(json: [String: Any]) {
        self.type = json["type"] as! String
        
        if let photoJson = json["photo"] as? [String: Any] {
            self.photo = NewItemAttachmentsPhoto(json: photoJson)
        }
    }
}

class NewItemAttachmentsPhoto {
    var photo130 = ""
    var photo604 = ""
    var photo807 = ""
    var height: Double?
    var width: Double?
    
    init(json: [String: Any]) {
        if let photo130Json = json["photo130"] as? String {
            self.photo130 = photo130Json
        }
        if let photo604Json = json["photo604"] as? String {
            self.photo604 = photo604Json
        }
        if let photo807Json = json["photo_807"] as? String {
            self.photo807 = photo807Json
        }
        if let heightJson = json["height"] as? Double {
            self.height = heightJson
        }
        if let widthJson = json["width"] as? Double {
            self.width = widthJson
        }
    }
}

class NewsProfiles {
    var id = 0
    var firstName = ""
    var lastName = ""
    var photo100 = ""
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.firstName = json["first_name"] as! String
        self.lastName = json["last_name"] as! String
        self.photo100 = json["photo_100"] as! String
    }
}


class NewsGroups {
    var id = 0
    var name = ""
    var photo100 = ""
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.photo100 = json["photo_100"] as! String
    }
}
