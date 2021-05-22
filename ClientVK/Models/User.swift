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
    let firstName: String
    let id: Int
    let lastName: String
    let photo100: URL
    let trackCode: String
    var name: String {
        return firstName + " " + lastName
    }
}
