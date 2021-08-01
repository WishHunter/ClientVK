//
//  FriendsTableViewCell.swift
//  ClientVK
//
//  Created by Denis Molkov on 27.02.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photo: AvatarViewControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Style

extension FriendsTableViewCell {
    func style() {
        self.contentView.layer.backgroundColor = UIColor.darkColor.cgColor
        label.textColor = UIColor.white
    }
}
