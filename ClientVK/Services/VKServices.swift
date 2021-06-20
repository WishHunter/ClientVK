//
//  VKServices.swift
//  ClientVK
//
//  Created by Denis Molkov on 13.04.2021.
//

import Foundation
import Alamofire
import RealmSwift
import PromiseKit

class VKServices {
    let baseURL = "https://api.vk.com/method/"
    let clientId = "7823707"
    let version = "5.21"
    
    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        
    //MARK: - load firends
    func loadFriends() {
        let friendsOperationQueue = OperationQueue()
        
        let getFriendsOperation = GetFriendsOperation(baseURL: baseURL, clientId: clientId, version: version)
        let parseFriendsOperation = ParseFriendsOperation()
        let saveFriendsOperation = SaveFriendsOperation()
        
        parseFriendsOperation.addDependency(getFriendsOperation)
        saveFriendsOperation.addDependency(parseFriendsOperation)
        
        friendsOperationQueue.addOperation(getFriendsOperation)
        friendsOperationQueue.addOperation(parseFriendsOperation)
        friendsOperationQueue.addOperation(saveFriendsOperation)
    }
    
    //MARK: - load communities
    func loadCommunities() {
        
        getCommunitiesPromise()
            .then(parseCommunitiesPromise(_:))
            .get { data in
                print(data[0])
            }
            .done(saveCommunitiesData(_:))
            .catch { error in
                print(error)
            }
    }
    
    func getCommunitiesPromise() -> Promise<Data> {
        let path = "groups.get"
        
        let parameters: Parameters = [
            "user_id": Session.instance.userId ?? "0",
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "extended": "1"
        ]
        
        let url = baseURL + path
        
        return Promise { resolver in
            AF.request(url, method: .get, parameters: parameters).responseData {
                response in
                guard let data = response.value else {
                    resolver.reject(AppError.noDataProvided)
                    return
                }
                
                resolver.fulfill(data)
            }
        }
    }
    
    func parseCommunitiesPromise(_ data: Data) -> Promise<[Group]> {
        
        return Promise { resolver in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let groups = try decoder.decode(Groups.self, from: data)
                resolver.fulfill(groups.response.items)
            } catch { resolver.reject(AppError.failedToDecode) }
        }
    }
    
    func saveCommunitiesData(_ groups: [Group]) {
        do {
            let realm = try Realm(configuration: config)
            realm.beginWrite()
            realm.add(groups, update: .modified)
            try realm.commitWrite()
        } catch {
            print(AppError.noDataSave)
        }
    }
    
    //MARK: - search communities
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
    
    //MARK: - load photos
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
    
    //MARK: - load news
    func loadNews(results: @escaping ([NewsItem], [NewsProfiles], [NewsGroups]) -> Void) {
        let path = "newsfeed.get"
        let parameters: Parameters = [
            "filters": "post",
            "access_token": Session.instance.token ?? "0",
            "v": version,
            "count": 20
        ]
                
        let url = baseURL + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            guard let json = response.value else { return }
            
            let result = json as! [String: Any]
            let response = result["response"] as! [String: Any]
            
            var posts: [NewsItem] = []
            var profiles: [NewsProfiles] = []
            var groups: [NewsGroups] = []
            let dispatchGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: dispatchGroup) {
                let postsJson = response["items"] as! [[String: Any]]
                posts = postsJson.map { NewsItem(json: $0) }
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                let profilesJson = response["profiles"] as! [[String: Any]]
                profiles = profilesJson.map { NewsProfiles(json: $0) }
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                let groupsJson = response["groups"] as! [[String: Any]]
                groups = groupsJson.map { NewsGroups(json: $0) }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                results(posts, profiles, groups)
            }
        }
    }
}

