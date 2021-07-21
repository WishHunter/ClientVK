//
//  UserPhotoAdapter.swift
//  ClientVK
//
//  Created by Denis Molkov on 21.07.2021.
//

import Foundation
import RealmSwift

final class UserPhotoAdapter {
    
    private let vkServices = VKServices()
    private var token: NotificationToken?
    
    private var realmNotificationTokens: [Int: NotificationToken] = [:]
    
    func getUserPhoto(inFriendId friendId: Int, then completion: @escaping ([UserPhotoAdapterModel]) -> Void) {
        vkServices.loadPhotos(friendId: friendId)
        
        guard let realm = try? Realm() else { return }
        
        let realmPhotos = realm.objects(UserPhoto.self).filter("ownerId = \(Int(friendId))")
        
        self.realmNotificationTokens[friendId]?.invalidate()
                
        token = realmPhotos.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .update(let realmPhotos, _, _, _):
                var photos: [UserPhotoAdapterModel] = []
                for realmPhoto in realmPhotos {
                    photos.append(self.photosUpdate(from: realmPhoto))
                }
                self.realmNotificationTokens[friendId]?.invalidate()
                completion(photos)
            case .error(let error):
                fatalError("\(error)")
            case .initial:
                break
            }
        }
        
        self.realmNotificationTokens[friendId] = token
    }
    
    private func photosUpdate(from rlmPhoto: UserPhoto) -> UserPhotoAdapterModel {
        var photo: String?
        if let image = rlmPhoto.photo604 {
            photo = image
        } else if let image = rlmPhoto.photo130 {
            photo = image
        }
        return UserPhotoAdapterModel(photo: photo ?? nil, likes: rlmPhoto.likes?.count ?? 0, reposts: rlmPhoto.reposts?.count ?? 0)
            
    }
}

