//
//  UserModel.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import Foundation

struct Friends: Codable {
    let response: FriendsResponce
}

struct FriendsResponce: Codable {
    let count: Int
    let items: [User]
}

struct User: Codable {
    let first_name: String
    let id: Int
    let last_name: String
    let photo_100: URL
    let track_code: String
    var name: String {
        return first_name + " " + last_name
    }
}
