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
        network.fetchProfile()
        network.observeProfile()
        network.observeMembers()
        network.observeTasks()
        network.observeMessages()
    }
    
    public static func fetchProfile() {
        Database.database().reference().child("member").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                Data.name = value["name"] as! String
                Data.registrationNumber = value["registrationNumber"] as! String
                Data.phoneNumber = value["phoneNumber"] as! Int
                Data.designation = value["designation"] as! String
                Data.departmentCode = value["department"] as! String
                if value["isAdmin"] as! Int == 0{
                    Data.isAdmin = false
                } else {
                    Data.isAdmin = true
                }
                if value["available"] as! Int == 0{
                    Data.isAvailable = false
                } else {
                    Data.isAvailable = true
                }
            }
            fetchMembers()
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    public static func fetchMembers() {
        Database.database().reference().child("member").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                Data.members.removeAll()
                for (key, val) in value{
                    var x = val as! NSDictionary
                    Data.members.append(x as! NSDictionary)
//                    if String(describing: x["department"]!) == Data.departmentCode{
//                        Data.members.append(x as! NSDictionary)
//                    }
                }
            }
            fetchTasks()
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    public static func fetchTasks() {
        Database.database().reference().child("task").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                Data.tasks.removeAll()
                Data.taskCodes.removeAll()
                for (key, val) in value{
                    var x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!) == Data.departmentCode{
                        Data.tasks.append(x as! NSDictionary)
                        Data.taskCodes.append(key as! String)
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
            fetchMessages()
            // ...
        }) { (error) in
            print("error")
            print(error.localizedDescription)
        }
    }
    
    public static func fetchMessages() {
        Database.database().reference().child("messages").observeSingleEvent(of: .value , with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                Data.messages.removeAll()
                for (key, val) in value{
                    let x = val as! NSDictionary
                    if String(describing: x["departmentCode"]!) == Data.departmentCode{
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
    
    public static func observeProfile() {
        Database.database().reference().child("member").child((Auth.auth().currentUser?.uid)!).observe(.childChanged, with: {_ in
            self.fetchProfile()
        })
    }
    
    
    public static func observeMembers() {
        Database.database().reference().child("member").observe(.childChanged, with: {_ in
            self.fetchMembers()
        })
    }
    
    public static func observeTasks() {
        Database.database().reference().child("task").observe(.childAdded, with: {_ in
            self.fetchTasks()
        })
        Database.database().reference().child("task").observe(.childChanged, with: {_ in
            self.fetchTasks()
        })
    }
    
    public static func observeMessages(){
        Database.database().reference().child("messages").observe(.childAdded, with: {_ in
            self.fetchMessages()
        })
        Database.database().reference().child("messages").observe(.childChanged, with: {_ in
            self.fetchMessages()
        })
    }
    
    public static func logout() -> Bool {
        do{
            try Auth.auth().signOut()
            Data.isLogged = false
            return true
        }catch{
            Data.isLogged = true
            return false
        }
    }
}
