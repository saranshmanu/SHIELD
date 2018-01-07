//
//  MembersTableViewCell.swift
//  SHIELD
//
//  Created by Saransh Mittal on 07/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UIView!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var registrationNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
