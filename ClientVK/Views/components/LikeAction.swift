//
//  LikeAction.swift
//  ClientVK
//
//  Created by Denis Molkov on 03.03.2021.
//

import UIKit

@IBDesignable
class LikeAction: UIControl {
    
    var numberOfLikes: Int = 0 {
        didSet {
            label.text = String(self.numberOfLikes)
        }
    }
    var isLiked: Bool = false
    
    private var label: UILabel!
    private var stackView: UIStackView!
    private var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        label = UILabel()
        button = UIButton(type: .system)
        
        stackView = UIStackView(arrangedSubviews: [label, button])
        
        addSubview(stackView)
        
        label.text = String(self.numberOfLikes)
        button.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        
        
        stile()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackConst()
//        stackView.frame = bounds
        
    }
    
    @objc private func likeTapped(_ sender: UIButton) {
        numberOfLikes = isLiked ? numberOfLikes - 1 : numberOfLikes + 1
        
        isLiked = !isLiked
        
        stateButton()
    }
}

extension LikeAction {
    private func stile() {
        stackView.axis = .horizontal
        stackView.spacing = 10
        stateButton()
    }
    
    private func stateButton() {
        if self.isLiked {
            button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
    }
    
    private func stackConst() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let heightConst = NSLayoutConstraint(item: stackView!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        let bottomConst = NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let rightConst = NSLayoutConstraint(item: stackView!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10)
        
        self.addConstraints([heightConst, bottomConst, rightConst])
    }
}
