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

    @IBAction func postAction(_ sender: Any) {
        if Data.isAdmin{
            var text = ""
            if form.allRows[0].baseValue != nil{
                text = form.allRows[0].baseValue! as! String
            } else {
                //perform an alert that the message field is empty
                return
            }
            var department = ""
            //to get the current date and time
            for i in 3...Data.departments.count-1{
                if form.allRows[i].baseValue != nil{
                    department = form.allRows[i].baseValue! as! String
                }
            }
            if department == ""{
                //perform an alert that the department is not selected
                return
            }
            let date = form.allRows[1].baseValue as! Date
            let time = form.allRows[2].baseValue as! Date
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
                "status" : "0",
                "name" :Data.name,
                "designation":Data.designation
            ]
            FIRDatabase.database().reference().child("task").childByAutoId().setValue(task)
            navigationController?.popToRootViewController(animated: true)
        } else {
            //perform an alert that the user is not authorised to send message on the group
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

