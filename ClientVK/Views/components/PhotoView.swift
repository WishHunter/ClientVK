//
//  PhotoView.swift
//  ClientVK
//
//  Created by Denis Molkov on 14.03.2021.
//

import UIKit

@IBDesignable
class PhotoView: UIView {
    
    private var photoView: UIImageView!
    
    open var photoName: String? {
        didSet {
            if let image = photoName {
                photoView.image = UIImage(named: image)
            } else {
                photoView.image = UIImage(systemName: "person.crop.circle")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        photoView = UIImageView()
        self.addSubview(photoView)
        
        photoView.image = UIImage(systemName: "person.crop.circle")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoView.frame = bounds
    }
}
