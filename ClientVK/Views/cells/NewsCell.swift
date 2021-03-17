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
        
        let newView = News()
        self.contentView.addSubview(newView)
        newView.frame.size.width = bounds.width
        newView.backgroundColor = UIColor.red
        
//        NSLayoutConstraint.activate([
//            newView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
//        ])
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func createView() {
    }
}
