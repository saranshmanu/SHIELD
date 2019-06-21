//
//  DepartmentMessagesViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 12/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class DepartmentMessagesViewController: UIViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        messagesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DepartmentMessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = Data.messages[indexPath.row] as NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentMessage", for: indexPath as IndexPath) as! departmentMessagesTableViewCell
        cell.messageTextField.text      = "\(message["message"] as! String)"
        cell.dateAndTime.text           = "\(message["date"] as! String), \(message["time"] as! String)"
        cell.messageSentByField.text    = "\(message["name"] as! String), \(message["designation"] as! String)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
