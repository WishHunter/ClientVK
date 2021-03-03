//
//  LikeAction.swift
//  ClientVK
//
//  Created by Denis Molkov on 03.03.2021.
//

import UIKit

@IBDesignable
class LikeAction: UIControl {
    
    var numberOfLikes: Int?
    
    private var imageView: UIImageView!
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initView()
    }
    
    private func initView() {
        imageView = UIImageView()
        label = UILabel()
        
        self.addSubview(label)
        self.addSubview(imageView)
        
        imageView?.image = UIImage(systemName: "hand.thumbsup")
        imageView?.highlightedImage = UIImage(systemName: "hand.thumbsup.fill")
        
        label?.text = String(self.numberOfLikes ?? 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
