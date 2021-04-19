//
//  PhotoToFriendCollectionViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 27.02.2021.
//

import UIKit

class PhotoToFriendCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User2?
    var viewFullScreen: Slider?
    var vkServices = VKServices()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkServices.loadPhotos()
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
        return user?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoToFriendCollectionViewCell

        if let image = user?.photos[indexPath.item][0] {
            cell.photo.image = UIImage(named: image)
        } else {
            cell.photo.image = UIImage(systemName: "person.crop.circle")
        }
        
        cell.likes.numberOfLikes = Int(user?.photos[indexPath.item][1] ?? "0") ?? 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = user?.photos[indexPath.item][0] {
            createFullScreenPhoto(indexPath.item)
        }
    }
}


extension PhotoToFriendCollectionViewController {
    
    
    
    func createFullScreenPhoto(_ index: Int) {
        viewFullScreen = Slider()
        viewFullScreen?.frame = self.view.bounds
        viewFullScreen?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.view.addSubview(viewFullScreen!)
        viewFullScreen?.activeImageIndex = index
        viewFullScreen?.user = self.user
        
        viewFullScreen?.createView()
        
    }
    
    
    
    
}
