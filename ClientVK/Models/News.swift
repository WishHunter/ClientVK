//
//  News.swift
//  ClientVK
//
//  Created by Denis Molkov on 31.05.2021.
//

import Foundation


class NewsItem {
    var sourceId = 0
    var date = 0
    var text = ""
    var attachments: [NewsItemAttachments] = []
    var comments = 0
    var likes = 0
    var reposts = 0
    
    init(json: [String: Any]) {
        self.sourceId = json["source_id"] as! Int
        self.date = json["date"] as! Int
        
        if let text = json["text"] as? String {
            self.text = text
        }
        
        if let attachmentsJson = json["attachments"] as? [[String: Any]] {
            self.attachments = attachmentsJson.map { NewsItemAttachments(json: $0) }
        }
        
        let commentsJson = json["comments"] as! [String: Any]
        self.comments = commentsJson["count"] as! Int
        
        let likesJson = json["likes"] as! [String: Any]
        self.likes = likesJson["count"] as! Int
        
        let repostsJson = json["reposts"] as! [String: Any]
        self.reposts = repostsJson["count"] as! Int
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
    
    init(json: [String: Any]) {
        self.photo130 = json["photo_130"] as! String
        self.photo604 = json["photo_604"] as! String
        self.photo807 = json["photo_807"] as! String
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

//// MARK: - AllNews
//struct AllNews: Decodable {
//    let response: NewsResponse
//}
//
//// MARK: - NewsResponse
//struct NewsResponse: Decodable {
//    let items: [NewsItem]
//    let profiles: [NewsProfile]
//    let groups: [NewsGroup]
//    let nextFrom: String
//}
//
//// MARK: - NewsGroup
//struct NewsGroup: Decodable {
//    let id: Int
//    let name, screenName: String
//    let isClosed: Int
//    let type: String
//    let isAdmin, isMember, isAdvertiser: Int
//    let photo50, photo100, photo200: String
//}
//
//// MARK: - NewsItem
//class NewsItem: Object, Decodable {
//    @objc dynamic var sourceId: Int = 0
//    @objc dynamic var date: Int = 0
//    @objc dynamic var canDoubtCategory: Bool = false
//    @objc dynamic var canSetCategory: Bool = false
//    @objc dynamic var postType, text: String?
//    @objc dynamic var markedAsAds: Int = 0
//    @objc dynamic var postSource: NewsPostSource?
//    @objc dynamic var comments: NewsComments?
//    @objc dynamic var likes: NewsLikes?
//    @objc dynamic var reposts: NewsReposts?
//    @objc dynamic var postId: Int = 0
//    @objc dynamic var type: String?
//    let integerList = List<NewsAttachment>()
//
//    override class func primaryKey() -> String? {
//        return "sourceId"
//    }
//}
//
//// MARK: - NewsAttachment
//class NewsAttachment: Object, Decodable {
//    @objc dynamic var type: String = ""
//    @objc dynamic var video: NewsVideo?
//    @objc dynamic var photo: NewsPhoto?
//}
//
//// MARK: - NewsPhoto
//class NewsPhoto: Object, Decodable {
//    @objc dynamic var albumId: Int = 0
//    @objc dynamic var date: Int = 0
//    @objc dynamic var id: Int = 0
//    @objc dynamic var ownerId: Int = 0
//    @objc dynamic var hasTags: Bool = false
//    @objc dynamic var accessKey: String?
//    @objc dynamic var height: Int = 0
//    @objc dynamic var photo1280, photo130, photo2560, photo604: String?
//    @objc dynamic var photo75, photo807: String?
//    @objc dynamic var text: String?
//    @objc dynamic var userId: Int = 0
//    @objc dynamic var width: Int = 0
//    @objc dynamic var postId: Int = 0
//}
//
//// MARK: - NewsVideo
//class NewsVideo: Object, Codable {
//    @objc dynamic var accessKey: String?
//    @objc dynamic var canComment: Int = 0
//    @objc dynamic var canLike: Int = 0
//    @objc dynamic var canRepost: Int = 0
//    @objc dynamic var canSubscribe: Int = 0
//    @objc dynamic var canAddToFaves: Int = 0
//    @objc dynamic var comments: Int = 0
//    @objc dynamic var date: Int = 0
//    @objc dynamic var videoDescription: String?
//    @objc dynamic var duration: Int = 0
//    @objc dynamic var photo130, photo320, photo800, photo1280: String?
//    @objc dynamic var firstFrame130, firstFrame160, firstFrame320, firstFrame800: String?
//    @objc dynamic var firstFrame1280: String?
//    @objc dynamic var width: Int = 0
//    @objc dynamic var height: Int = 0
//    @objc dynamic var id: Int = 0
//    @objc dynamic var ownerId: Int = 0
//    @objc dynamic var title, trackCode: String?
//    @objc dynamic var views: Int = 0
//}
//
//// MARK: - NewsComments
//class NewsComments: Object, Decodable {
//    @objc dynamic var count: Int = 0
//    @objc dynamic var canPost: Int = 0
//}
//
//// MARK: - NewsLikes
//class NewsLikes: Object, Decodable {
//    @objc dynamic var count: Int = 0
//    @objc dynamic var userLikes: Int = 0
//    @objc dynamic var canLike: Int = 0
//    @objc dynamic var canPublish: Int = 0
//}
//
//// MARK: - NewsPostSource
//class NewsPostSource: Object, Decodable {
//    @objc dynamic var type: String?
//}
//
//// MARK: - NewsReposts
//class NewsReposts: Object, Decodable {
//    @objc dynamic var count: Int = 0
//    @objc dynamic var userReposted: Int = 0
//}
//
//// MARK: - NewsProfile
//struct NewsProfile: Decodable {
//    let firstName: String
//    let id: Int
//    let lastName: String
//    let sex: Int
//    let screenName: String
//    let photo50, photo100: String
//    let onlineInfo: NewsOnlineInfo
//    let online: Int
//}
//
//// MARK: - NewsOnlineInfo
//struct NewsOnlineInfo: Decodable {
//    let visible, isOnline, isMobile: Bool
//}
