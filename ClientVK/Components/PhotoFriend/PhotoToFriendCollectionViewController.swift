//
//  PhotoToFriendCollectionViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 27.02.2021.
//

import UIKit
import RealmSwift

class PhotoToFriendCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var userId: Int?
    var photos: Results<UserPhoto>?
    var vkServices = VKServices()
    var token: NotificationToken?
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = PhotoService(container: collectionView)
        vkServices.loadPhotos(friendId: userId!)
        realmObserve()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = Int(self.collectionView.bounds.width)
        let numberofItem = collectionViewWidth % 3 == 0 ? 3 : 4
        let width = collectionViewWidth / numberofItem
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoToFriendCollectionViewCell
        
        guard let photo = photos?[indexPath.item] else { return cell}

        if let image = photo.photo604 {
            cell.photo.image = photoService?.photo(atIndexpath: indexPath, byUrl: image)
        } else if let image = photo.photo130 {
            cell.photo.image = photoService?.photo(atIndexpath: indexPath, byUrl: image)
        } else {
            cell.photo.image = UIImage(systemName: "person.crop.circle")
        }
        
        cell.likes.numberOfLikes = photo.likes!.count
        cell.likes.isLiked = (photo.likes!.userLikes != 0)
        return cell
    }
}

//MARK: - RealmLoadData

extension PhotoToFriendCollectionViewController {
    
    func realmObserve() {
        guard let realm = try? Realm() else { return }
        
        photos = realm.objects(UserPhoto.self).filter("ownerId = \(Int(userId!))")
        token = photos?.observe {[weak self] (changes: RealmCollectionChange) in
            
            guard let self = self,
                  let collectionView = self.collectionView else { return }
            
            switch changes {
                case .initial:
                    collectionView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    collectionView.performBatchUpdates({
                        collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                        collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                    }, completion: nil)
                case .error(let error):
                    fatalError("\(error)")
            }

        }
        
    }
}
