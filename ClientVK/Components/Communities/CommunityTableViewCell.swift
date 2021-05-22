//
//  CommunityTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 14.03.2021.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photo: AvatarViewControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
