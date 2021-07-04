//
//  PhotosTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 30.05.2021.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var containerView: UIView!
    var photoService: PhotoService?
    var table: UITableView?
    var aspectRatio: Double?
    
    var photos: [String] = [] {
        didSet {
            if photos.count > 0 {
                createContainer()
            }
            
            if photos.count == 1 {
                createSinglePhoto()
            } else if photos.count > 1 {
                createMultiplePhotos()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - create Container
    func createContainer() {
        containerView = UIView()
        
        self.addSubview(containerView)
        containerView.frame = bounds
        
        containerView.layer.backgroundColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstrain = containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        NSLayoutConstraint.activate([
            topConstrain,
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        topConstrain.priority = UILayoutPriority(999)
    }
    
    //MARK: - create Single Photos
    func createSinglePhoto() {
        let photoView = UIImageView()
        
//        photoView.image = self.photos[0]
        photoView.loadImage(self.photos[0])
        
        photoView.contentMode = .scaleAspectFill
        photoView.layer.masksToBounds = true
        
        containerView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            photoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            photoView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            photoView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            photoView.heightAnchor.constraint(equalToConstant: CGFloat(Double(containerView.frame.width) * (aspectRatio ?? 1)))
        ])
    }
    
    //MARK: - create Multiple Photos
    func createMultiplePhotos() {
        var index = 0
        while index < self.photos.count && index < 4 {
            let photoView = UIImageView()
//            photoView.image = self.photos[index]
            photoView.loadImage(self.photos[index])
            
            photoView.contentMode = .scaleAspectFill
            photoView.layer.masksToBounds = true
            
            containerView.addSubview(photoView)
            
            photoView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1)
            ])
            
            switch self.photos.count {
            case 2:
                constraintsDoublePhotos(photoView: photoView, index: index)
            case 3:
                constraintsTriplePhotos(photoView: photoView, index: index)
            default:
                constraintsQuadruplePhotos(photoView: photoView, index: index)
            }
            
            index += 1
        }
    }
    
    //MARK: - constraints Double Photos
    func constraintsDoublePhotos(photoView: UIImageView, index: Int) {
        switch index {
        case 0:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
                photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 0.5),
            ])
        default:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
                photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 0.5),
                photoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
            ])
        }
    }
    //MARK: - constraints Triple Photos
    func constraintsTriplePhotos(photoView: UIImageView, index: Int) {
        switch index {
        case 0:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            ])
        case 1:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
            ])
        default:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
                photoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
            ])
        }
    }
    
    //MARK: - constraints Quadruple Photos
    func constraintsQuadruplePhotos(photoView: UIImageView, index: Int) {
        switch index {
        case 0:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            ])
        case 1:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
            ])
        case 2:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
            ])
        case 3:
            NSLayoutConstraint.activate([
                photoView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
                photoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
                photoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)
            ])
        default:
            break
        }
    }
}

