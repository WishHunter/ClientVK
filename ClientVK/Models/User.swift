//
//  UserModel.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import Foundation
import RealmSwift

class Friends: Decodable {
    var response: FriendsResponce
}

class FriendsResponce: Decodable {
    var count: Int
    var items: [User]
}

class User: Object, Decodable {
    @objc dynamic var firstName: String
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo100: String
    @objc dynamic var trackCode: String
    @objc dynamic var name: String {
        return firstName + " " + lastName
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
