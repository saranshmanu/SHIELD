//
//  DepartmentTableViewCell.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: UITableViewCell {

    @IBOutlet weak var departmentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
