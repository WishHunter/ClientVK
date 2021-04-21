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
    let albumId: Int
    let date: Date
    let hasTags: Bool
    let height: Int?
    let id: Int
    let ownerId: Int
    let photo130: URL?
    let photo604: URL?
    let photo75: URL?
    let photo807: URL?
    let photo1280: URL?
    let photo2560: URL?
    let text: String
    let width: Int?
    let likes: PhotoLikes
    let reposts: PhotoReposts
}

struct PhotoLikes: Codable {
    let userLikes: Int
    let count: Int
}

struct PhotoReposts: Codable {
    let count: Int
}
