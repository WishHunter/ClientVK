//
//  AvatarView.swift
//  ClientVK
//
//  Created by Denis Molkov on 02.03.2021.
//

import UIKit

@IBDesignable class AvatarView: UIView {
    
    //MARK: - INSPECTABLES
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.4
    @IBInspectable var shadowPosition: CGSize = CGSize(width: 5, height: 5)
    @IBInspectable var shadowRadius: CGFloat = CGFloat(7)
    
    private var imageView: UIImageView!
    private var backView: UIView!
    
    override func draw(_ rect: CGRect) {
            super.draw(rect)
    }
    
    open var imageName: String? {
        didSet {
            if let image = imageName {
                imageView.image = UIImage(named: image)
            } else {
                imageView.image = UIImage(systemName: "person.crop.circle")
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
        imageView = UIImageView()
        backView = UIView()
        
        self.addSubview(backView)
        backView.addSubview(imageView)

        imageView.image = UIImage(systemName: "person.crop.circle")
        
        self.styles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frame = bounds
        imageView.frame = bounds
    }
}

extension AvatarView {
    private func styles() {
        backView.backgroundColor = .blue
        
        let imageLayer = imageView.layer
        let backLayer = backView.layer
        
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = self.bounds.width / 2
        
        backLayer.cornerRadius = self.bounds.width / 2
        backLayer.shadowColor = self.shadowColor.cgColor
        backLayer.shadowOpacity = self.shadowOpacity
        backLayer.shadowOffset = self.shadowPosition
        backLayer.shadowRadius = self.shadowRadius
    }
}
