//
//  News.swift
//  ClientVK
//
//  Created by d.molkov on 17.03.2021.
//

import UIKit

class News: UIView {
    
    private var aboutAutor: UIView!
    private var text: UITextView!
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
        text = UITextView()
        text.text = "Не всегда UICollectionViewFlowLayout соответствует требованиям к дизайну, поэтому приходится создавать свой layout. Для этого надо добавить наследника класса UICollectionViewLayout и переопределить следующие его методы:"
        
        self.addSubview(text)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        text.frame = bounds
        text.frame.size.height = text.contentSize.height
//        text.frame.size.height = 200
        
//        NSLayoutConstraint.activate([
//            text.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
//        ])
    }
}
