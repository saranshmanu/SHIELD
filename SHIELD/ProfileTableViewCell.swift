//
//  ProfileTableViewCell.swift
//  SHIELD
//
//  Created by Saransh Mittal on 08/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var taskDeadline: UILabel!
    @IBOutlet weak var taskObjective: UILabel!
    @IBOutlet weak var dateOfAssignedTask: UILabel!
    @IBOutlet weak var taskGivenByName: UILabel!
    @IBOutlet weak var status: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
