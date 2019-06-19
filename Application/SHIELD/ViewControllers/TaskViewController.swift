//
//  ProfileViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 08/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        workTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workTableView.dequeueReusableCell(withIdentifier: "work", for: indexPath as IndexPath) as! ProfileTableViewCell
        if (Data.tasks[indexPath.row]["status"]! as! Int) == 0{
            cell.status.backgroundColor = Data.redColor
        } else {
            cell.status.backgroundColor = UIColor.clear
        }
        cell.taskDeadline.text = "Deadline: " + (Data.tasks[indexPath.row]["deadline"]! as! String)
        cell.taskObjective.text = Data.tasks[indexPath.row]["message"]! as! String
        cell.taskGivenByName.text = Data.tasks[indexPath.row]["name"]! as! String
        cell.dateOfAssignedTask.text = Data.tasks[indexPath.row]["date"]! as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workTableView.deselectRow(at: indexPath, animated: true)
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        let complete = UIAlertAction(title: "Completed", style: .default) { _ in
            Database.database().reference().child("task").child(Data.taskCodes[indexPath.row]).child("status").setValue(1)
        }
        let notCompleted = UIAlertAction(title: "Not completed", style: .default) { _ in
            Database.database().reference().child("task").child(Data.taskCodes[indexPath.row]).child("status").setValue(0)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        actionSheetControllerIOS8.addAction(cancel)
        actionSheetControllerIOS8.addAction(complete)
        actionSheetControllerIOS8.addAction(notCompleted)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    @IBOutlet weak var workTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppear(_:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        workTableView.delegate = self
        workTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func dropShadow() {
//        infoView.layer.masksToBounds = false
//        infoView.layer.shadowColor = UIColor.black.cgColor
//        infoView.layer.shadowOpacity = 0.7
//        infoView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        infoView.layer.shadowRadius = 10
//        infoView.layer.shadowPath = UIBezierPath(rect: infoView.bounds).cgPath
//        infoView.layer.shouldRasterize = true
//        infoView.layer.rasterizationScale = UIScreen.main.scale
//    }

}
