//
//  Slider.swift
//  ClientVK
//
//  Created by Denis Molkov on 24.03.2021.
//

import UIKit

class Slider: UIView {
    
    enum PositionImage {
        case center, left, right
    }

    var previewImage: UIImageView?
    var activeImage: UIImageView?
    var nextImage: UIImageView?
    var activeImageIndex: Int?
    var user: User2?
    
    func createView() {
        previewImage = UIImageView()
        activeImage = UIImageView()
        nextImage = UIImageView()
        
        addImage(imageView: previewImage!)
        addImage(imageView: activeImage!)
        addImage(imageView: nextImage!)
        
        createImages()
        
        self.addSubview(previewImage!)
        self.addSubview(activeImage!)
        self.addSubview(nextImage!)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        leftSwipe.direction = .left
        self.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
        rightSwipe.direction = .right
        self.addGestureRecognizer(rightSwipe)
    }
    
    private func createImages() {
        if (activeImageIndex! - 1) >= 0, let image = user?.photos[activeImageIndex! - 1][0] {
            posImage(imageView: previewImage!, image: image, position: .left)
        }
        if let image = user?.photos[activeImageIndex!][0] {
            posImage(imageView: activeImage!, image: image, position: .center)
        }
        if (activeImageIndex! + 1) < (user?.photos.count)!, let image = user?.photos[activeImageIndex! + 1][0] {
            posImage(imageView: nextImage!, image: image, position: .right)
        }
    }
    
    private func addImage(imageView: UIImageView) {
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
    }
    
    private func posImage(imageView: UIImageView, image: String, position: PositionImage) {
        imageView.image = UIImage(named: image)
        switch position {
            case .left:
                imageView.frame.origin.x = -self.bounds.width
                imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            case .center:
                imageView.frame.origin.x = (self.bounds.width / 2) - (imageView.frame.width / 2)
            case .right:
                imageView.frame.origin.x = self.bounds.width
                imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }
    }
    
    @objc func onSwipe(_ sender: UISwipeGestureRecognizer) {
        self.createImages()
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            switch sender.direction {
                case .left:
                    if (self.activeImageIndex! + 1) < (self.user?.photos.count)! {
                        self.activeImage?.frame.origin.x = -self.bounds.width
                        self.nextImage?.frame.origin.x = (self.bounds.width / 2) - ((self.nextImage?.frame.width)! / 2)
                    }
                case .right:
                    if (self.activeImageIndex! - 1) >= 0 {
                        self.activeImage?.frame.origin.x = self.bounds.width
                        self.previewImage?.frame.origin.x = (self.bounds.width / 2) - ((self.previewImage?.frame.width)! / 2)
                    }
                default:
                    break
                }
        }
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.2,
                       options: .curveEaseInOut,
                       animations: {
                        switch sender.direction {
                            case .left:
                                self.nextImage?.transform = .identity
                            case .right:
                                self.previewImage?.transform = .identity
                            default:
                                break
                        }
                       },
                       completion: nil)
        
        
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
            }
        }
        
        animator.startAnimation()
    }
}
