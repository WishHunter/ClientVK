//
//  AvatarViewControl.swift
//  ClientVK
//
//  Created by Denis Molkov on 02.03.2021.
//

import UIKit

@IBDesignable class AvatarViewControl: UIControl {
    
    //MARK: - INSPECTABLES
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.4
    @IBInspectable var shadowPosition: CGSize = CGSize(width: 5, height: 5)
    @IBInspectable var shadowRadius: CGFloat = CGFloat(7)
    
    private var button: UIButton!
    private var imageView: UIImageView!
    
    open var imageName: URL? {
        didSet {
            if let image = imageName {
                let task = URLSession.shared.dataTask(with: image) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                    
                    task.resume()
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
        button = UIButton(type: .system)
        button.addTarget(self, action: #selector(avatarTouch), for: .touchUpInside)
        
        self.addSubview(button)
        button.addSubview(imageView)

        imageView.image = UIImage(systemName: "person.crop.circle")
        
        self.styles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
        imageView.frame = bounds
    }
    
    //MARK: - Action
    
    @objc private func avatarTouch() {
        sendActions(for: .touchUpInside)
    }
}

extension AvatarViewControl {
    private func styles() {
        button.backgroundColor = .blue
        
        let imageLayer = imageView.layer
        let backLayer = button.layer
        
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = self.bounds.width / 2
        
        backLayer.cornerRadius = self.bounds.width / 2
        backLayer.shadowColor = self.shadowColor.cgColor
        backLayer.shadowOpacity = self.shadowOpacity
        backLayer.shadowOffset = self.shadowPosition
        backLayer.shadowRadius = self.shadowRadius
    }
}
