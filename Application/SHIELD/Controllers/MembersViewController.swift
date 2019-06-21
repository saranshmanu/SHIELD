//
//  MembersViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 07/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Firebase

class MembersViewController: UIViewController {

    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var registrationNumberLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var membersTableView: UITableView!
    
    @IBAction func statusToggle(_ sender: Any) {
        guard let status  = Data.User.isAvailable else { return }
        NetworkEngine.User.changeMemberOnlineStatus(to: status)
        availableLabel.isHidden = !status
    }
    
    func contactToNumber(at: Int) {
        if let url = URL(string: "tel://\(at)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        membersTableView.reloadData()
        nameLabel.text = Data.User.name
        departmentLabel.text = Constant.findDepartmentName(departmentCode: Data.User.departmentCode) + " Department"
        registrationNumberLabel.text = Data.User.registrationNumber
        guard let status  = Data.User.isAvailable else { return }
        availableLabel.isHidden = !status
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.members.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let member = Data.members[indexPath.row] as NSDictionary
        let available = member["available"] as! Int
        if available == 1 {
            let number = member["phoneNumber"] as! Int
            contactToNumber(at: number)
        } else {
            UIViewController.alert(title: "Could not place call", message: "The member seems to be offline. Please call again later after some time", view: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = Data.members[indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "members", for: indexPath as IndexPath) as! MembersTableViewCell
        cell.registrationNumber.text    = member["registrationNumber"] as? String
        cell.name.text                  = member["name"] as? String
        let available = member["available"] as! Int
        if available == 0{
            cell.status.backgroundColor = UIColor.clear
        } else {
            cell.status.backgroundColor = Data.ThemeColor.redColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
