//
//  Session.swift
//  ClientVK
//
//  Created by Denis Molkov on 10.04.2021.
//

import Foundation

final
class Session {
    
    static let instance = Session()
    private init() {}
    
    var token: String? = nil
    var userId: String? = nil
}
