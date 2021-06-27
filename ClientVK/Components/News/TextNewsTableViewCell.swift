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
            createShowMoreLink()
//            self.textNews.text = shortText
//            if shortText != fullText {
//                createShowMoreLink()
//            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        createShowMoreLink()
    }
    
    func createShowMoreLink() {
        let button = UIButton(type: .system)
        
//        self.addSubview(button)
        container.addSubview(button)
        
        button.setTitle("Show more", for: .normal)
        button.setTitle("Less more", for: .selected)
        self.textNews.text = shortText

        textNews.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10),
            container.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            container.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -10),
            container.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -10),
            textNews.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 0),
            textNews.leftAnchor.constraint(greaterThanOrEqualTo: container.leftAnchor, constant: 0),
            textNews.rightAnchor.constraint(greaterThanOrEqualTo: container.rightAnchor, constant: 0),
            textNews.bottomAnchor.constraint(greaterThanOrEqualTo: button.topAnchor, constant: -10),
            button.leftAnchor.constraint(greaterThanOrEqualTo: container.leftAnchor, constant: 0),
            button.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor, constant: 0)
        ])
        
        print(self.bounds.height)
    }
}
