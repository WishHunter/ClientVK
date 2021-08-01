//
//  VKServicesProxy.swift
//  ClientVK
//
//  Created by Denis Molkov on 01.08.2021.
//

import Foundation

class VKServicesProxy: VKServicesInterface {
    let vkServices: VKServices
    
    init(vkServices: VKServices) {
        self.vkServices = vkServices
    }
    
    func log(name: String) {
        print("=============================")
        print("called func \(name)")
        print("=============================")
    }
    
    func loadFriends() {
        vkServices.loadFriends()
        log(name: "loadFriends")
    }
    
    func loadCommunities() {
        vkServices.loadCommunities()
        log(name: "loadCommunities")
    }
    
    func searchCommunities(stroke: String = " ", completion: @escaping ([Group]) -> Void) {
        vkServices.searchCommunities(stroke: stroke, completion: completion)
        log(name: "searchCommunities")
    }
    
    func loadPhotos(friendId: Int) {
        vkServices.loadPhotos(friendId: friendId)
        log(name: "loadPhotos")
    }
    
    func loadNews(time: String = "", startFrom: String = "", results: @escaping ([NewsItem], [NewsProfiles], [NewsGroups], String) -> Void) {
        vkServices.loadNews(time: time, startFrom: startFrom, results: results)
        log(name: "loadNews")
    }
    
    
}
