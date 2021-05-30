//
//  HeaderNewsView.swift
//  ClientVK
//
//  Created by Denis Molkov on 23.05.2021.
//

import UIKit

class HeaderNewsView: UIView {
    
    private var avatarAuthorVIew = AvatarViewControl()
    private var nameAuthorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    //MARK: - Init
    
    func setupView() {
        avatarAuthorVIew.imageName = URL(fileURLWithPath: "https://99px.ru/sstorage/53/2013/06/tmb_72172_3185.jpg")
        nameAuthorLabel.text = "Test text"
        
        self.addSubview(avatarAuthorVIew)
        self.addSubview(nameAuthorLabel)
    }
    
    //MARK: - Style
    
}
