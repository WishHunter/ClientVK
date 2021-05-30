//
//  News.swift
//  ClientVK
//
//  Created by Denis Molkov on 31.05.2021.
//

import Foundation
import RealmSwift

// MARK: - AllNews
struct AllNews: Decodable {
    let response: NewsResponse
}

// MARK: - NewsResponse
struct NewsResponse: Decodable {
    let items: [NewsItem]
    let profiles: [NewsProfile]
    let groups: [NewsGroup]
    let nextFrom: String
}

// MARK: - NewsGroup
struct NewsGroup: Decodable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String
}

// MARK: - NewsItem
class NewsItem: Object, Decodable {
    @objc dynamic var sourceId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var canDoubtCategory: Bool = false
    @objc dynamic var canSetCategory: Bool = false
    @objc dynamic var postType, text: String?
    @objc dynamic var markedAsAds: Int = 0
    @objc dynamic var postSource: NewsPostSource?
    @objc dynamic var comments: NewsComments?
    @objc dynamic var likes: NewsLikes?
    @objc dynamic var reposts: NewsReposts?
    @objc dynamic var postId: Int = 0
    @objc dynamic var type: String?
    let integerList = List<NewsAttachment>()
    
    override class func primaryKey() -> String? {
        return "sourceId"
    }
}

// MARK: - NewsAttachment
class NewsAttachment: Object, Decodable {
    @objc dynamic var type: String = ""
    @objc dynamic var video: NewsVideo?
    @objc dynamic var photo: NewsPhoto?
}

// MARK: - NewsPhoto
class NewsPhoto: Object, Decodable {
    @objc dynamic var albumId: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var hasTags: Bool = false
    @objc dynamic var accessKey: String?
    @objc dynamic var height: Int = 0
    @objc dynamic var photo1280, photo130, photo2560, photo604: String?
    @objc dynamic var photo75, photo807: String?
    @objc dynamic var text: String?
    @objc dynamic var userId: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var postId: Int = 0
}

// MARK: - NewsVideo
class NewsVideo: Object, Codable {
    @objc dynamic var accessKey: String?
    @objc dynamic var canComment: Int = 0
    @objc dynamic var canLike: Int = 0
    @objc dynamic var canRepost: Int = 0
    @objc dynamic var canSubscribe: Int = 0
    @objc dynamic var canAddToFaves: Int = 0
    @objc dynamic var comments: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var videoDescription: String?
    @objc dynamic var duration: Int = 0
    @objc dynamic var photo130, photo320, photo800, photo1280: String?
    @objc dynamic var firstFrame130, firstFrame160, firstFrame320, firstFrame800: String?
    @objc dynamic var firstFrame1280: String?
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    @objc dynamic var title, trackCode: String?
    @objc dynamic var views: Int = 0
}

// MARK: - NewsComments
class NewsComments: Object, Decodable {
    @objc dynamic var count: Int = 0
    @objc dynamic var canPost: Int = 0
}

// MARK: - NewsLikes
class NewsLikes: Object, Decodable {
    @objc dynamic var count: Int = 0
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var canLike: Int = 0
    @objc dynamic var canPublish: Int = 0
}

// MARK: - NewsPostSource
class NewsPostSource: Object, Decodable {
    @objc dynamic var type: String?
}

// MARK: - NewsReposts
class NewsReposts: Object, Decodable {
    @objc dynamic var count: Int = 0
    @objc dynamic var userReposted: Int = 0
}

// MARK: - NewsProfile
struct NewsProfile: Decodable {
    let firstName: String
    let id: Int
    let lastName: String
    let sex: Int
    let screenName: String
    let photo50, photo100: String
    let onlineInfo: NewsOnlineInfo
    let online: Int
}

// MARK: - NewsOnlineInfo
struct NewsOnlineInfo: Decodable {
    let visible, isOnline, isMobile: Bool
}
