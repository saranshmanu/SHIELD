
//
//  departmentMessagesTableViewCell.swift
//  SHIELD
//
//  Created by Saransh Mittal on 12/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class departmentMessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageSentByField: UILabel!
    @IBOutlet weak var messageTextField: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
