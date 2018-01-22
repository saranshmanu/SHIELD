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
    var messages:[NSDictionary] = []
    
    override func viewDidAppear(_ animated: Bool) {
        messagesTableView.reloadData()
    }
    
    func fetchMessages() {
        FIRDatabase.database().reference().child("messages").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                self.messages.removeAll()
                for (key, val) in value{
                    let x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!)  == Data.departmentCode{
                        self.messages.append(val as! NSDictionary)
                    }
                }
                self.messagesTableView.reloadData()
            }
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMessages()
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: {_ in
            self.fetchMessages()
        })
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
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "departmentMessage", for: indexPath as IndexPath) as! departmentMessagesTableViewCell
        cell.messageTextField.text = messages[indexPath.row]["message"]! as! String
        cell.dateAndTime.text = (messages[indexPath.row]["date"]! as! String) + ", " + (messages[indexPath.row]["time"]! as! String)
        cell.messageSentByField.text = (messages[indexPath.row]["name"]! as! String) + ", " + (messages[indexPath.row]["designation"]! as! String)
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
