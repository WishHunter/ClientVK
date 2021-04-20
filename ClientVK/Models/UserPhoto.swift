//
//  UserPhoto.swift
//  ClientVK
//
//  Created by Denis Molkov on 20.04.2021.
//

import Foundation

struct UserPhotos: Codable {
    let response: UserPhotosResponse
}

struct UserPhotosResponse: Codable {
    let count: Int
    let items: [UserPhoto]
}

struct UserPhoto: Codable {
    let album_id: Int
    let date: Date
    let has_tags: Bool
    let height: Int?
    let id: Int
    let owner_id: Int
    let photo_130: URL?
    let photo_604: URL?
    let photo_75: URL?
    let photo_807: URL?
    let photo_1280: URL?
    let photo_2560: URL?
    let text: String
    let width: Int?
    let likes: PhotoLikes
    let reposts: PhotoReposts
}

struct PhotoLikes: Codable {
    let user_likes: Int
    let count: Int
}

struct PhotoReposts: Codable {
    let count: Int
}
