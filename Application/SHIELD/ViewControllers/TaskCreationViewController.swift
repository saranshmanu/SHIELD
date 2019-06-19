//
//  TaskCreationViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class TaskCreationViewController: FormViewController {

    public func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func postAction(_ sender: Any) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        if Data.isAdmin{
            if Reachability.isConnectedToNetwork(){
                // connected to the internet
                var text = ""
                if form.allRows[0].baseValue != nil{
                    text = form.allRows[0].baseValue! as! String
                } else {
                    //perform an alert that the message field is empty
                    UIViewController.removeSpinner(spinner: sv)
                    alert(title: "Oops!", message: "Please enter the message!")
                    return
                }
                var department = "Startups"
                //to get the current date and time
                for i in 3...(12-1){
                    if form.allRows[i].baseValue != nil{
//                        department = form.allRows[i].baseValue! as! String
                    }
                }
                if department == ""{
                    //perform an alert that the department is not selected
                    UIViewController.removeSpinner(spinner: sv)
                    alert(title: "Oops!", message: "Please select a department to which you want to assign this task!")
                    return
                }
                let date = form.allRows[1].baseValue as! Date
                let time = form.allRows[2].baseValue as! Date
                if date == nil || time == nil{
                    UIViewController.removeSpinner(spinner: sv)
                    alert(title: "Oops!", message: "Please select a deadline to finish this task!")
                    return
                }
                var calendar = Calendar.current
                var deadline = String(calendar.component(.day, from: date)) + " " + Data.findMonth(month: String(calendar.component(.month, from: date))) + " " + String(calendar.component(.year, from: date)) + ", " + String(calendar.component(.hour, from: time)) + ":" + String(calendar.component(.minute, from: time)) + ":" + String(calendar.component(.second, from: time))
                
                print()
                var task = [
                    "departmentCode": Data.findDepartmentCode(code: department),
                    "registrationNumber":Data.registrationNumber,
                    "time":Data.findCurrentTime(),
                    "date":Data.findCurrentDate(),
                    "deadline" : deadline,
                    "message":text,
                    "status" : 0,
                    "name" :Data.name,
                    "designation":Data.designation
                    ] as [String : Any]
                Database.database().reference().child("task").childByAutoId().setValue(task){
                    (err, resp) in
                    if err == nil{
                        UIViewController.removeSpinner(spinner: sv)
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        UIViewController.removeSpinner(spinner: sv)
                        self.alert(title: "Oops!", message: "Posting not successfull")
                    }
                }
            }else{
                // not connected to the internet
                UIViewController.removeSpinner(spinner: sv)
                self.alert(title: "Oops!", message: "You are not connected to the internet!")
            }
        } else {
            //perform an alert that the user is not authorised to send message on the group
            UIViewController.removeSpinner(spinner: sv)
            alert(title: "Oops!", message: "You are not authorised to create tasks!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            let department = Data.departments
            for option in department {
                form.last! <<< ListCheckRow<String>(option){ listRow in
                    listRow.title = option
                    listRow.selectableValue = option
                    listRow.value = nil
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

