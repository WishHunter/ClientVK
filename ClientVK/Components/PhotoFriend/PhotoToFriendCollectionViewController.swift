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
    var photos = [UserPhoto]()
    var vkServices = VKServices()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        collectionView.reloadData()
                
        vkServices.loadPhotos(friendId: userId!) {[weak self] in
            self?.loadData()
            self?.collectionView.reloadData()
        }
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
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoToFriendCollectionViewCell

        if let image = photos[indexPath.item].photo604 {
            let imageURL = URL(string: image)!
            let data = try? Data(contentsOf: imageURL)
            cell.photo.image = UIImage(data: data!)
        } else if let image = photos[indexPath.item].photo130 {
            let imageURL = URL(string: image)!
            let data = try? Data(contentsOf: imageURL)
            cell.photo.image = UIImage(data: data!)
        } else {
            cell.photo.image = UIImage(systemName: "person.crop.circle")
        }
        
        cell.likes.numberOfLikes = photos[indexPath.item].likes!.count
        cell.likes.isLiked = (photos[indexPath.item].likes!.userLikes != 0)
        return cell
    }
}

//MARK: - RealmLoadData

extension PhotoToFriendCollectionViewController {
    func loadData() {
        do {
            let realm = try Realm()
            let photos = realm.objects(UserPhoto.self).filter("ownerId = \(Int(userId!))")
            self.photos = Array(photos)
            
        } catch { print(error) }
    }
}
