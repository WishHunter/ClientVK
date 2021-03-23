//
//  PhotoToFriendCollectionViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 27.02.2021.
//

import UIKit

class PhotoToFriendCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        if let image = user?.photos[indexPath.item][0] {
            createFullScreenPhoto(image)
        }
    }
}


extension PhotoToFriendCollectionViewController {
    
    enum PositionImage {
        case center, left, right
    }
    func createFullScreenPhoto(_ image: String) {
        let view = UIView()
        addImage(image: image, position: .center)
        
        self.view.addSubview(view)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func addImage(image: String, position: PositionImage) {
        let imageView = UIImageView()
        
        view.frame = self.view.bounds
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        imageView.image = UIImage(named: image)
        imageView.frame = view.bounds
        imageView.transform = CGAffineTransform(translationX: 0, y: 0)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        view.addSubview(imageView)
    }
    
    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
                case .left:
                    print("Left Swipe")
                case .right:
                    print("Right Swipe")
                default:
                    break
                }
    }
}
