//
//  UserModel.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import Foundation

struct User {
    var name: String
    var photo: String?
    
    static var fakeNames: [String] = ["Harry Ruth","Ross Jackson","Bruce Debra","Cook Allen","Carolyn Gerald","Morgan Harris","Albert Raymond","Walker Carter","Randy Jacqueline","Reed Torres","Larry Joseph","Barnes Nelson","Lois Carlos","Wilson Sanchez","Jesse Ralph","Campbell Clark","Ernest Jean","Rogers Alexander","Theresa Stephen","Patterson Roberts","Henry Eric","Simmons Long","Michelle Amanda","Perry Scott","Frank Teresa","Butler Diaz","Shirley Wanda"]
    
    static var fakeContent: [User] {
        var fakeArray: [User] = []
        
        for _ in 0...15 {
            fakeArray.append(User(
                                name: fakeNames[Int.random(in: 0..<fakeNames.count)],
                                photo: String(Int.random(in: 1...15))))
        }
        
        return fakeArray
    }
}
