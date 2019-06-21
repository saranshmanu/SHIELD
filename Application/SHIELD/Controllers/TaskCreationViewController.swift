//
//  TaskCreationViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka

class TaskCreationViewController: FormViewController {
    
    func initTaskCreationForm() {
        form
            +++ Section("Message")
            <<< TextAreaRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            +++ Section("Deadline")
            <<< DateInlineRow(){
                $0.title = "Date"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TimeInlineRow(){
                $0.title = "Time"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            +++ SelectableSection<ListCheckRow<String>>("Department", selectionType: .singleSelection(enableDeselection: true))
        let department = Constant.departments
        for option in department {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
    }
    
    func cannotSend(title: String, message: String) {
        let spinner = UIViewController.displaySpinner(onView: self.view)
        UIViewController.removeSpinner(spinner: spinner)
        UIViewController.alert(title: title, message: message, view: self)
    }
    
    func getDeadline(date: Date, time: Date) -> String{
        let calendar = Calendar.current
        return "\(calendar.component(.day, from: date)) \(Constant.findMonth(month: String(calendar.component(.month, from: date)))) \(calendar.component(.year, from: date)), \(calendar.component(.hour, from: time)):\(calendar.component(.minute, from: time)):\(calendar.component(.second, from: time))"
    }
    
    @IBAction func postAction(_ sender: Any) {
        if Data.User.isAdmin == false {
            cannotSend(title: "Oops!", message: "You are not authorised to create tasks!")
            return
        }
        if Reachability.isConnectedToNetwork() == false {
            cannotSend(title: "Oops!", message: "You are not connected to the internet!")
            return
        }
        if form.allRows[0].baseValue == nil{
            cannotSend(title: "Oops!", message: "Message empty!")
            return
        }
        var department = ""
        for i in 3...(12-1){
            if form.allRows[i].baseValue != nil{
                department = form.allRows[i].baseValue! as! String
            }
        }
        if department == "" {
            cannotSend(title: "Oops!", message: "You are not authorised to create tasks!")
            UIViewController.alert(title: "Oops!", message: "Please select a department to which you want to assign this task!", view: self)
            return
        }
        let date = form.allRows[1].baseValue as! Date
        let time = form.allRows[2].baseValue as! Date
        let deadline: String = getDeadline(date: date, time: time)
        let task = form.allRows[0].baseValue! as! String
        NetworkEngine.User.createTask(deadline: deadline, message: task, department: department) { (success) in
            if success {
                let spinner = UIViewController.displaySpinner(onView: self.view)
                UIViewController.removeSpinner(spinner: spinner)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.cannotSend(title: "Oops!", message: "Posting not successfull")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTaskCreationForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
