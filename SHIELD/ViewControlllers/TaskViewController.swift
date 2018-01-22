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
    
    var tasks:[NSDictionary] = []
    var codes:[String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        workTableView.reloadData()
    }
    
    func fetchTasks() {
        FIRDatabase.database().reference().child("task").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                self.tasks.removeAll()
                for (key, val) in value{
                    var x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!) == Data.departmentCode{
                        self.tasks.append(x as! NSDictionary)
                        self.codes.append(key as! String)
                    }
                }
                self.workTableView.reloadData()
            }
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workTableView.dequeueReusableCell(withIdentifier: "work", for: indexPath as IndexPath) as! ProfileTableViewCell
        if (tasks[indexPath.row]["status"]! as! String)  == "0"{
        } else {
            cell.status.backgroundColor = UIColor.clear
        }
        cell.taskDeadline.text = "Deadline: " + (tasks[indexPath.row]["deadline"]! as! String)
        cell.taskObjective.text = tasks[indexPath.row]["message"]! as! String
        cell.taskGivenByName.text = tasks[indexPath.row]["name"]! as! String
        cell.dateOfAssignedTask.text = tasks[indexPath.row]["date"]! as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        workTableView.deselectRow(at: indexPath, animated: true)
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        let saveActionButton = UIAlertAction(title: "Completed", style: .default) { _ in
            FIRDatabase.database().reference().child("task").child(self.codes[indexPath.row]).child("status").setValue("1")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        actionSheetControllerIOS8.addAction(cancel)
        actionSheetControllerIOS8.addAction(saveActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    @IBOutlet weak var workTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTasks()
        FIRDatabase.database().reference().child("task").observe(.childAdded, with: {_ in
            self.fetchTasks()
        })
        FIRDatabase.database().reference().child("task").observe(.childChanged, with: {_ in
            self.fetchTasks()
        })
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
