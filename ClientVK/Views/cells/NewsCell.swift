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
        newView.frame.size.width = bounds.width
        self.contentView.addSubview(newView)
    }
}