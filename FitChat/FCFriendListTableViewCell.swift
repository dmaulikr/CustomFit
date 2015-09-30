//
//  FCFriendListTableViewCell.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-09-29.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import UIKit

class FCFriendListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
