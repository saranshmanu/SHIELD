//
//  DepartmentMessagesViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 12/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Firebase

class DepartmentMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        messagesTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        // Do any additional setup after loading the view.
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "departmentMessage", for: indexPath as IndexPath) as! departmentMessagesTableViewCell
        cell.messageTextField.text = Data.messages[indexPath.row]["message"]! as! String
        cell.dateAndTime.text = (Data.messages[indexPath.row]["date"]! as! String) + ", " + (Data.messages[indexPath.row]["time"]! as! String)
        cell.messageSentByField.text = (Data.messages[indexPath.row]["name"]! as! String) + ", " + (Data.messages[indexPath.row]["designation"]! as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
