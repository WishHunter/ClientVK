//
//  Group.swift
//  ClientVK
//
//  Created by Denis Molkov on 21.04.2021.
//

import Foundation

struct Groups: Codable {
    let response: GroupsResponse
}

struct GroupsResponse: Codable {
    let count: Int
    let items: [Group]
}

struct Group: Codable {
    let id: Int
    let name: String
    let screenName: String
    let isClosed: Int
    let type: String
    let isAdmin: Int
    let isMember: Int
    let isAdvertiser: Int
    let photo50: URL?
    let photo100: URL?
    let photo200: URL?
}
