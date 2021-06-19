//
//  HeaderNewsTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 30.05.2021.
//

import UIKit

class HeaderNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: AvatarViewControl!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        photo.imageName = URL(string: "https://solovey.su/upload/image/2013-12/2334/preview-16-9.jpg")
        name.text = "Petrov Sviatoslav"
        date.text = "23.02.2022"
    }
}
