//
//  VKServices.swift
//  ClientVK
//
//  Created by Denis Molkov on 13.04.2021.
//

import Foundation
import Alamofire


class VKServices {
    let baseURL = "https://api.vk.com/method/"
    let clientId = "7823707"
    let version = "5.21"
    
    func loadFriends(completion: @escaping ([User]) -> Void) {
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
                print(response.value!)
                guard let data = response.value else { return }
                do {
                    let users = try JSONDecoder().decode(Friends.self, from: data)
                    completion(users.response.items)
                } catch {
                    print(error)
                }
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
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            print(response.value!)
        }
    }
    
    func searchCommunities(stroke: String = " ") {
        let path = "groups.search"
        
        let parameters: Parameters = [
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "q": stroke
        ]
        
        let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            print(response.value!)
        }
    }
    
    func loadPhotos(friendId: String = String(Session.instance.userId!)) {
        let path = "photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": friendId,
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "no_service_albums": 1
        ]
         let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            print(response.value!)
        }
    }
}
