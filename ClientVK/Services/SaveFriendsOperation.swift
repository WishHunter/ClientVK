//
//  SaveFriendsOperation.swift
//  ClientVK
//
//  Created by Denis Molkov on 19.06.2021.
//

import Foundation
import RealmSwift

class SaveFriendsOperation: Operation {
    
    override func main() {
        guard let parseFriendsOperation = dependencies.first as? ParseFriendsOperation,
              let friends = parseFriendsOperation.outputFriends else { return }
        
        do {
            let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
            realm.beginWrite()
            realm.add(friends.response.items, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
