//
//  Communities.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import Foundation

struct Communities {
    var name: String
    var photo: String?
    
    static var fakeNames: [String] = ["Food","Travel","Sport","Eating","Smoke","Cake","Drink","News","Fake news","Films"]
    
    
    static var fakeContent: [Communities] {
        var fakeArray: [Communities] = []
        
        for index in 0...9 {
            fakeArray.append(Communities(
                                name: fakeNames[index],
                                photo: String(Int.random(in: 1...15))))
        }
        
        return fakeArray
    }
}
