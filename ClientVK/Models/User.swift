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
    let photo_100: String
    let track_code: String
    var name: String {
        return first_name + last_name
    }
}

struct User2 {
    var name: String
    var photo: String?
    var photos: [[String]]
    
    static var fakeNames: [String] = ["Harry Ruth","Ross Jackson","Bruce Debra","Cook Allen","Carolyn Gerald","Morgan Harris","Albert Raymond","Walker Carter","Randy Jacqueline","Reed Torres","Larry Joseph","Barnes Nelson","Lois Carlos","Wilson Sanchez","Jesse Ralph","Campbell Clark","Ernest Jean","Rogers Alexander","Theresa Stephen","Patterson Roberts","Henry Eric","Simmons Long","Michelle Amanda","Perry Scott","Frank Teresa","Butler Diaz","Shirley Wanda"]
    
    
    static var fakePhotos: [[String]] = [
        ["1", "23"],
        ["2", "12"],
        ["3", "46"],
        ["4", "23"],
        ["5", "12"],
        ["6", "46"],
        ["7", "23"],
        ["8", "12"],
        ["9", "125"],
    ]
    
    static var fakeContent: [User2] {
        var fakeArray: [User2] = []
        
        for _ in 0...15 {
            fakeArray.append(User2(
                                name: fakeNames[Int.random(in: 0..<fakeNames.count)],
                                photo: String(Int.random(in: 1...15)),
                                photos: fakePhotos))
        }
        
        return fakeArray
    }
}
