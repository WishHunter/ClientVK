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
    var table: UITableView?
    var indexPath: IndexPath?
    var isHiddenText: Bool = true
    var button: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func createShowMoreLink() {
        button = UIButton(type: .system)
        button?.setTitle("Show more", for: .normal)
        button?.setTitleColor(.lightGray, for: .selected)
        button?.addTarget(self, action: #selector(showMore), for: .touchUpInside)
        
        guard let button = self.button else {
            return
        }
        container.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        textNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 30),
            textNews.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            button.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 10)
        ])
        
        print(self.bounds.height)
    }
    
    @objc private func showMore() {
        guard let table = self.table else { return }
        
        if isHiddenText {
            isHiddenText = false
            textNews.text = fullText
            button?.setTitle("Less more", for: .normal)
        } else {
            isHiddenText = true
            textNews.text = shortText
            button?.setTitle("Show more", for: .normal)
        }

        table.beginUpdates()
        table.endUpdates()
    }
}
