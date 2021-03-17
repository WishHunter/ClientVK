//
//  News.swift
//  ClientVK
//
//  Created by d.molkov on 17.03.2021.
//

import UIKit

class News: UIView {
    
    private var aboutAutor: UIView!
    private var text: UILabel!
    private var photo: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        text = UILabel()
        text.text = "Не всегда UICollectionViewFlowLayout соответствует требованиям к дизайну, поэтому приходится создавать свой layout. Для этого надо добавить наследника класса UICollectionViewLayout и переопределить следующие его методы:"
        
        self.addSubview(text)
        
//        NSLayoutConstraint.activate([
//            text.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        text.frame.size.width = bounds.width
        text.frame.size.height = 90
//        text.frame = bounds
//        text.lineBreakMode = .byWordWrapping
//        text.numberOfLines = 0
        
        
    }
}
