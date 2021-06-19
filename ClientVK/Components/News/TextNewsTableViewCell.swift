//
//  TextNewsTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 30.05.2021.
//

import UIKit

class TextNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textNews: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textNews.text = "This property is nil by default. Assigning a new value to this property also replaces the value of the attributedText property with the same text, although without any inherent style attributes. Instead the label styles the new string using shadowColor, textAlignment, and other style-related properties of the class."
    }
}
