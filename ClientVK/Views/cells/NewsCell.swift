//
//  NewsCell.swift
//  ClientVK
//
//  Created by d.molkov on 17.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func createView() {
        let newView = News()
        self.contentView.addSubview(newView)
        
        NSLayoutConstraint.activate([
            newView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            newView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            newView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            newView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}
