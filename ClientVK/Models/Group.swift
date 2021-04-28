//
//  Group.swift
//  ClientVK
//
//  Created by Denis Molkov on 21.04.2021.
//

import Foundation
import RealmSwift

struct Groups: Decodable {
    let response: GroupsResponse
}

struct GroupsResponse: Decodable {
    let count: Int
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var screenName: String
    @objc dynamic var isClosed: Int
    @objc dynamic var type: String
    @objc dynamic var isAdmin: Int
    @objc dynamic var isMember: Int
    @objc dynamic var isAdvertiser: Int
    @objc dynamic var photo50: String?
    @objc dynamic var photo100: String?
    @objc dynamic var photo200: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
