//
//  TextNewsTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 30.05.2021.
//

import UIKit

class TextNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var textNews: UILabel!
    
    var fullText: String?
    var shortText: String? {
        didSet {
            self.textNews.text = shortText
            if shortText != fullText {
                createShowMoreLink()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createShowMoreLink() {
        let button = UIButton(type: .system)
        button.setTitle("Show more", for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.addTarget(self, action: #selector(showMore), for: .touchDown)
        container.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        textNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textNews.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            button.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
        
        print(self.bounds.height)
    }
    
    @objc private func showMore(_ sender: UIButton) {
        print(fullText!)
    }
}
