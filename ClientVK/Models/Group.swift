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
    let screen_name: String
    let is_closed: Int
    let type: String
    let is_admin: Int
    let is_member: Int
    let is_advertiser: Int
    let photo_50: URL?
    let photo_100: URL?
    let photo_200: URL?
}
