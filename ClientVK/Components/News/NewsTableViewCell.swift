//
//  NewsTableViewCell.swift
//  ClientVK
//
//  Created by Vadim on 19.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    private var textNewsLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textNewsLabel.text = "Experimental text"
        textNewsLabel.frame = bounds
        
        self.addSubview(textNewsLabel)
    }
}
