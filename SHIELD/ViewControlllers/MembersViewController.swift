//
//  MembersViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 07/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Firebase

class MembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var registrationNumberLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var membersTableView: UITableView!
    
    @IBAction func statusToggle(_ sender: Any) {
        if Data.isAvailable == true{
            FIRDatabase.database().reference().child("member").child((FIRAuth.auth()?.currentUser?.uid)!).child("available").setValue("0")
            availableLabel.isHidden = false
        } else {
            FIRDatabase.database().reference().child("member").child((FIRAuth.auth()?.currentUser?.uid)!).child("available").setValue("1")
            availableLabel.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.members.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "members", for: indexPath as IndexPath) as! MembersTableViewCell
        if Data.members[indexPath.row]["available"] as! String == "0"{
            cell.status.backgroundColor = UIColor.clear
        } else {
            cell.status.backgroundColor = UIColor.init(red: 82/255, green: 102/255, blue: 143/255, alpha: 1.0)
        }
        cell.name.text = Data.members[indexPath.row]["name"] as! String
        cell.registrationNumber.text = Data.members[indexPath.row]["registrationNumber"] as! String
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        membersTableView.reloadData()
        nameLabel.text = Data.name
        departmentLabel.text = Data.findDepartmentName(departmentCode: Data.departmentCode) + " Department"
        registrationNumberLabel.text = Data.registrationNumber
        if Data.isAvailable == true {
            availableLabel.isHidden = false
        } else {
            availableLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        membersTableView.delegate = self
        membersTableView.dataSource = self
        availableLabel.isHidden = true
        FIRDatabase.database().reference().child("member").child((FIRAuth.auth()?.currentUser?.uid)!).observe(.childChanged, with: {(snapshot) in
            if snapshot.value! as! String == "0"{
                Data.isAvailable = false
                self.availableLabel.isHidden = true
            } else {
                Data.isAvailable = true
                self.availableLabel.isHidden = false
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//        @IBOutlet weak var animation: UIView!
//        let animationView = LOTAnimationView(name: "data")
//        animationView?.frame = CGRect(x: -65, y: -77, width: 200, height: 200)
////        animationView?.center = self.animation.center
//        animationView?.contentMode = .scaleAspectFill
//        animationView?.loopAnimation = true
//        animation.addSubview(animationView!)
//        animationView?.play()
