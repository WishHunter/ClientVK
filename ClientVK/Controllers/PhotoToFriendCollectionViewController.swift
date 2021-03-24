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
    var viewFullScreen: UIView?
    var previewImage: UIImageView?
    var activeImage: UIImageView?
    var nextImage: UIImageView?
    var activeImageIndex: Int?
    
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
        if let _ = user?.photos[indexPath.item][0] {
            createFullScreenPhoto(indexPath.item)
        }
    }
}


extension PhotoToFriendCollectionViewController {
    
    enum PositionImage {
        case center, left, right
    }
    
    func createFullScreenPhoto(_ index: Int) {
        activeImageIndex = index
        viewFullScreen = UIView()
        viewFullScreen!.frame = self.view.bounds
        viewFullScreen!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.view.addSubview(viewFullScreen!)
        
        previewImage = UIImageView()
        activeImage = UIImageView()
        nextImage = UIImageView()
        
        createImages()
        viewFullScreen!.addSubview(previewImage!)
        viewFullScreen!.addSubview(activeImage!)
        viewFullScreen!.addSubview(nextImage!)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func createImages() {
        if (activeImageIndex! - 1) >= 0, let image = user?.photos[activeImageIndex! - 1][0] {
            addImage(imageView: previewImage!, image: image, position: .left)
        }
        if let image = user?.photos[activeImageIndex!][0] {
            addImage(imageView: activeImage!, image: image, position: .center)
        }
        if (activeImageIndex! + 1) < (user?.photos.count)!, let image = user?.photos[activeImageIndex! + 1][0] {
            addImage(imageView: nextImage!, image: image, position: .right)
        }
    }
    
    func addImage(imageView: UIImageView, image: String, position: PositionImage) {
               
        imageView.image = UIImage(named: image)
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        switch position {
            case .left:
                imageView.frame.origin.x = -self.view.bounds.width
            case .center:
                imageView.frame.origin.x = (self.view.bounds.width / 2) - (imageView.frame.width / 2)
            case .right:
                imageView.frame.origin.x = self.view.bounds.width
            }
    }
    
    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) {
                
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            switch sender.direction {
                case .left:
                    if (self.activeImageIndex! + 1) < (self.user?.photos.count)! {
                        self.activeImage?.frame.origin.x = -self.view.bounds.width
                        self.nextImage?.frame.origin.x = (self.view.bounds.width / 2) - ((self.nextImage?.frame.width)! / 2)
                    }
                case .right:
                    if (self.activeImageIndex! - 1) >= 0 {
                        self.activeImage?.frame.origin.x = self.view.bounds.width
                        self.previewImage?.frame.origin.x = (self.view.bounds.width / 2) - ((self.nextImage?.frame.width)! / 2)
                    }
                default:
                    break
                }
        }
        
        animator.addCompletion{position in
            if position == .end {
                switch sender.direction {
                    case .left:
                        if (self.activeImageIndex! + 1) < (self.user?.photos.count)! {
                            self.activeImageIndex! += 1
                        }
                    case .right:
                        if (self.activeImageIndex! - 1) >= 0 {
                            self.activeImageIndex! -= 1
                        }
                    default:
                        break
                    }
                self.createImages()
            }
        }
        
        animator.startAnimation()
    }
}
