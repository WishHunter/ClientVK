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
    var photos: [UserPhotoAdapterModel] = []
    var photoLoadService = UserPhotoAdapter()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoLoadService.getUserPhoto(inFriendId: (userId ?? Int(Session.instance.userId!))!, then: {
            [weak self] photos in
            self?.photos = photos
            self?.collectionView.reloadData()
        })
        
        self.collectionView.layer.backgroundColor = UIColor.darkColor.cgColor
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
        
        let photo = photos[indexPath.item]

        if let image = photo.photo {
            cell.photo.loadImage(image)
        } else {
            cell.photo.image = UIImage(systemName: "person.crop.circle")
        }
        
        cell.likes.numberOfLikes = photo.likes
        cell.likes.isLiked = (photo.likes != 0)
        return cell
    }
}
