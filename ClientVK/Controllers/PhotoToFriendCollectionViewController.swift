//
//  PhotoToFriendCollectionViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 27.02.2021.
//

import UIKit

class PhotoToFriendCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user: User?
    
    var photo = [
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
        "https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = Int(self.collectionView.bounds.width)
        let numberofItem = collectionViewWidth % 3 == 0 ? 3 : 4
        let width = collectionViewWidth / numberofItem
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photos.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoToFriendCollectionViewCell

        if let image = user?.photos[indexPath.item][0] {
            cell.photo.image = UIImage(named: image)
        } else {
            cell.photo.image = UIImage(systemName: "person.crop.circle")
        }
        
        cell.likes.numberOfLikes = Int(user?.photos[indexPath.item][1] ?? "0") ?? 0
        return cell
    }    
}
