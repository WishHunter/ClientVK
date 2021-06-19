//
//  FooterNewsTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 30.05.2021.
//

import UIKit

class FooterNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var commentNumber: UILabel!
    @IBOutlet weak var shareNumber: UILabel!
    @IBOutlet weak var viewsNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
