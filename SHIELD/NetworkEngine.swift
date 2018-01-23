//
//  NetworkEngine.swift
//  SHIELD
//
//  Created by Saransh Mittal on 23/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation
import Firebase

class network:UIViewController {
    
    public static func loadData(){
        network.fetchMessages()
        network.observeMessages()
        network.fetchTasks()
        network.observeTasks()
    }
    
    public static func observeTasks(){
        FIRDatabase.database().reference().child("task").observe(.childAdded, with: {_ in
            self.fetchTasks()
        })
        FIRDatabase.database().reference().child("task").observe(.childChanged, with: {_ in
            self.fetchTasks()
        })
    }
    
    public static func observeMessages(){
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: {_ in
            self.fetchMessages()
        })
    }
    
    public static func fetchTasks() {
        FIRDatabase.database().reference().child("task").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                Data.tasks.removeAll()
                for (key, val) in value{
                    var x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!) == Data.departmentCode{
                        Data.tasks.append(x as! NSDictionary)
                        Data.taskCodes.append(key as! String)
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    public static func fetchMessages() {
        FIRDatabase.database().reference().child("messages").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                Data.messages.removeAll()
                for (key, val) in value{
                    let x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!)  == Data.departmentCode{
                        Data.messages.append(val as! NSDictionary)
                    }
                }
            }
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
}
