//
//  ProfileViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 08/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var workTableView: UITableView!
    
    func initDataObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidAppear(_:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func createOptionMenu(index: Int) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Options", message: "", preferredStyle: .actionSheet)
        let cancel   = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        let complete = UIAlertAction(title: "Completed", style: .default) { _ in
            NetworkEngine.User.changeTaskCompletionStatus(to: true, code: Data.taskCodes[index])
        }
        let notCompleted = UIAlertAction(title: "Not completed", style: .default) { _ in
            NetworkEngine.User.changeTaskCompletionStatus(to: false, code: Data.taskCodes[index])
        }
        actionSheetControllerIOS8.addAction(cancel)
        actionSheetControllerIOS8.addAction(complete)
        actionSheetControllerIOS8.addAction(notCompleted)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initDataObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        workTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        workTableView.delegate = self
        workTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = Data.tasks[indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "work", for: indexPath as IndexPath) as! ProfileTableViewCell
        cell.taskDeadline.text          = "Deadline: \(task["deadline"] as! String)"
        cell.taskObjective.text         = "\(task["message"] as! String)"
        cell.dateOfAssignedTask.text    = "\(task["date"] as! String)"
        cell.taskGivenByName.text       = "\(indexPath.row)"
        let status = task["status"] as! Int
        if status == 0 {
            cell.status.backgroundColor = Data.ThemeColor.redColor
        } else {
            cell.status.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        createOptionMenu(index: indexPath.row)
    }
}
