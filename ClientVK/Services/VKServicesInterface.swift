//
//  VKServicesInterface.swift
//  ClientVK
//
//  Created by Denis Molkov on 01.08.2021.
//

import Foundation

protocol VKServicesInterface {
    func loadFriends()
    func loadCommunities()
    func searchCommunities(stroke: String, completion: @escaping ([Group]) -> Void)
    func loadPhotos(friendId: Int)
    func loadNews(time: String, startFrom: String, results: @escaping ([NewsItem], [NewsProfiles], [NewsGroups], String) -> Void)
}
