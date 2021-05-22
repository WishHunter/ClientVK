//
//  VKServices.swift
//  ClientVK
//
//  Created by Denis Molkov on 13.04.2021.
//

import Foundation
import Alamofire
import RealmSwift

class VKServices {
    let baseURL = "https://api.vk.com/method/"
    let clientId = "7823707"
    let version = "5.21"
    
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        
    func loadFriends() {
        let path = "friends.get"
        
        let parameters: Parameters = [
            "user_id": Session.instance.userId ?? "0",
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "fields": "photo_100"
        ]
        
        let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
                guard let data = response.value else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let users = try decoder.decode(Friends.self, from: data)
                    
                    self.saveFriendsData(users.response.items)
                } catch {
                    print(error)
                }
            }
    }
    
    func saveFriendsData(_ friends: [User]) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(friends, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadCommunities() {
        let path = "groups.get"
        
        let parameters: Parameters = [
            "user_id": Session.instance.userId ?? "0",
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "extended": "1"
        ]
        
        let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
            guard let data = response.value else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let groups = try decoder.decode(Groups.self, from: data)
                self.saveCommunitiesData(groups.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func saveCommunitiesData(_ groups: [Group]) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(groups, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func searchCommunities(stroke: String = " ", completion: @escaping ([Group]) -> Void) {
        let path = "groups.search"
        
        let parameters: Parameters = [
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "q": stroke
        ]
        
        let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
            guard let data = response.value else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let groups = try decoder.decode(Groups.self, from: data)
                completion(groups.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func loadPhotos(friendId: Int = Int(Session.instance.userId!)!) {
        let path = "photos.getAll"
                
        let parameters: Parameters = [
            "owner_id": friendId,
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "no_service_albums": 0,
            "count": 50,
            "extended": 1
        ]
         let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
            guard let data = response.value else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photos = try decoder.decode(UserPhotos.self, from: data)
                self.savePhotosData(photos.response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func savePhotosData(_ photos: [UserPhoto]) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(photos, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
