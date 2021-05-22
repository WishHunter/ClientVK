//
//  FirebaseAuthUser.swift
//  ClientVK
//
//  Created by Denis Molkov on 16.05.2021.
//

import Foundation
import Firebase

class FirebaseAuthUser {
    let idUser: Int
    let ref: DatabaseReference?
    
    init(idUser: Int) {
        self.ref = nil
        self.idUser = idUser
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let idUser = value["idUser"] as? Int else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.idUser = idUser
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "idUser": idUser
        ]
    }
}

