//
//  NetworkEngine.swift
//  SHIELD
//
//  Created by Saransh Mittal on 23/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation
import Firebase

class NetworkEngine {
    class Authentication {
        public static func login(username: String, password: String, completion: @escaping (Bool) -> ()) {
            Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
                if error == nil {
                    Data.User.uid = (Auth.auth().currentUser?.uid)!
                    Data.User.username = username
                    Data.User.password = password
                    Data.User.isLogged = true
                    completion(true)
                } else {
                    Data.User.isLogged = false
                    completion(false)
                }
            }
        }
        
        public static func registration(name: String, registrationNumber: String, phoneNumber: Int, email: String, password: String, department: String, designation: String, completion: @escaping (Bool) -> ()) {
            let register = [
                "department"            : Constant.findDepartmentCode(code: department),
                "registrationNumber"    : registrationNumber,
                "designation"           : designation,
                "phoneNumber"           : phoneNumber,
                "email"                 : email,
                "name"                  : name,
                "isAdmin"               : 0,
                "available"             : 1
                ] as [String : Any]
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    Database.database().reference().child("member").child((Auth.auth().currentUser?.uid)!).setValue(register) {
                        (error, response) in
                        if error == nil {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                } else {
                    completion(false)
                }
            }
        }
        
        public static func logout() -> Bool {
            do {
                try Auth.auth().signOut()
                Data.User.isLogged = false
                return true
            } catch {
                Data.User.isLogged = true
                return false
            }
        }
    }
    
    class User {
        public static func loadData(){
            NetworkEngine.User.fetchProfile()
            NetworkEngine.User.observeProfile()
            NetworkEngine.User.observeMembers()
            NetworkEngine.User.observeTasks()
            NetworkEngine.User.observeMessages()
        }
        
        public static func createTask(deadline: String, message: String, department: String, completion: @escaping (Bool) -> ()) {
            let task = [
                "departmentCode"        : Constant.findDepartmentCode(code: department),
                "registrationNumber"    : Data.User.registrationNumber,
                "time"                  : Data.findCurrentTime(),
                "date"                  : Data.findCurrentDate(),
                "designation"           : Data.User.designation,
                "name"                  : Data.User.name,
                "deadline"              : deadline,
                "message"               : message,
                "status"                : 0
                ] as [String : Any]
            
            Database.database().reference().child("task").childByAutoId().setValue(task){
                (error, response) in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        
        public static func createMessage(message: String, department: String, completion: @escaping (Bool) -> ()) {
            let message = [
                "departmentCode"        : Constant.findDepartmentCode(code: department),
                "time"                  : Data.findCurrentTime(),
                "date"                  : Data.findCurrentDate(),
                "registrationNumber"    : Data.User.registrationNumber,
                "designation"           : Data.User.designation,
                "name"                  : Data.User.name,
                "message"               : message
            ]
            Database.database().reference().child("messages").childByAutoId().setValue(message) {
                (error, response) in
                if error == nil{
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        
        public static func fetchProfile() {
            Database.database().reference().child("member").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value , with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    Data.User.name                   = value["name"] as! String
                    Data.User.registrationNumber     = value["registrationNumber"] as! String
                    Data.User.phoneNumber            = value["phoneNumber"] as! Int
                    Data.User.designation            = value["designation"] as! String
                    Data.User.departmentCode         = value["department"] as! String
                    if value["isAdmin"] as! Int == 0 {
                        Data.User.isAdmin = false
                    } else {
                        Data.User.isAdmin = true
                    }
                    if value["available"] as! Int == 0 {
                        Data.User.isAvailable = false
                    } else {
                        Data.User.isAvailable = true
                    }
                }
                fetchMembers()
            }) { (error) in
                print("error")
                print(error.localizedDescription)
            }
        }
        
        public static func changeMemberOnlineStatus(to: Bool) {
            let status: Bool = to
            Database.database().reference().child("member").child(Data.User.uid).child("available").setValue(status)
        }
        
        public static func fetchMembers() {
            Database.database().reference().child("member").observeSingleEvent(of: .value , with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary{
                    Data.members.removeAll()
                    for (_, val) in value{
                        let x = val as! NSDictionary
                        Data.members.append(x)
                        //                    if String(describing: x["department"]!) == Data.departmentCode{
                        //                        Data.members.append(x as! NSDictionary)
                        //                    }
                    }
                }
                fetchTasks()
            }) { (error) in
                print("error")
                print(error.localizedDescription)
            }
        }
        
        public static func changeTaskCompletionStatus(to: Bool, code: String) {
            let status: Bool = to
            Database.database().reference().child("task").child(code).child("status").setValue(status)
        }
        
        public static func fetchTasks() {
            Database.database().reference().child("task").observeSingleEvent(of: .value , with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary{
                    Data.tasks.removeAll()
                    Data.taskCodes.removeAll()
                    for (key, val) in value{
                        let x = val as! NSDictionary
                        if String(describing: x["departmentCode"]!) == Data.User.departmentCode{
                            Data.tasks.append(x)
                            Data.taskCodes.append(key as! String)
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }
                fetchMessages()
            }) { (error) in
                print("error")
                print(error.localizedDescription)
            }
        }
        
        public static func fetchMessages() {
            Database.database().reference().child("messages").observeSingleEvent(of: .value , with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary{
                    Data.messages.removeAll()
                    for (_, val) in value{
                        let x = val as! NSDictionary
                        if String(describing: x["departmentCode"]!) == Data.User.departmentCode{
                            Data.messages.append(val as! NSDictionary)
                        }
                    }
                }
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
    }
    
}
