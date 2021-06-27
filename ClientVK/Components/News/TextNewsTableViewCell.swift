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
//            if shortText != fullText {
//                createShowMoreLink()
//            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        createShowMoreLink()
    }
    
    func createShowMoreLink() {
        let button = UIButton(type: .system)
        
//        self.addSubview(button)
        container.addSubview(button)
        
        button.setTitle("Show more", for: .normal)
        button.setTitle("Less more", for: .selected)

//        NSLayoutConstraint.activate([
//            textNews.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10),
//            textNews.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
//            textNews.rightAnchor.constraint(greaterThanOrEqualTo: self.rightAnchor, constant: -10),
//            textNews.bottomAnchor.constraint(greaterThanOrEqualTo: button.topAnchor, constant: 10),
//            button.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor, constant: 10),
//        ])
    }
}
