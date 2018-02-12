//
//  MessageCreationViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka
import Firebase



class MessageCreationViewController: FormViewController {

    var departmentName:String = ""
    
    public func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func postAction(_ sender: Any) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        if Data.isAdmin{
            // connected to the internet
            if Reachability.isConnectedToNetwork(){
                var text = ""
                if form.allRows[0].baseValue != nil{
                    text = form.allRows[0].baseValue! as! String
                } else {
                    //perform an alert that the message field is empty
                    UIViewController.removeSpinner(spinner: sv)
                    alert(title: "Oops!", message: "Message is empty!")
                    return
                }
                var department = ""
                //to get the current date and time
                for i in 1...(10-1){
                    if form.allRows[i].baseValue != nil{
                        department = form.allRows[i].baseValue! as! String
                    }
                }
                if department == ""{
                    //perform an alert that the department is not selected
                    UIViewController.removeSpinner(spinner: sv)
                    alert(title: "Oops!", message: "Select a department to post the message!")
                    return
                }
                var message = [
                    "departmentCode": Data.findDepartmentCode(code: department),
                    "registrationNumber":Data.registrationNumber,
                    "time":Data.findCurrentTime(),
                    "date":Data.findCurrentDate(),
                    "message":text,
                    "name" :Data.name,
                    "designation":Data.designation
                ]
                FIRDatabase.database().reference().child("messages").childByAutoId().setValue(message) {
                    (error, response) in
                    if error == nil{
                        UIViewController.removeSpinner(spinner: sv)
                        self.navigationController?.popToRootViewController(animated: true)
                    } else {
                        UIViewController.removeSpinner(spinner: sv)
                        self.alert(title: "Oops!", message: "Message failed to get delivered!")
                    }
                }
            }else{
                UIViewController.removeSpinner(spinner: sv)
                self.alert(title: "Oops!", message: "You are not connected to the internet!")
            }
        } else {
            //perform an alert that the user is not authorised to send message on the group
            UIViewController.removeSpinner(spinner: sv)
            alert(title: "Oops!", message: "You are not authorised to post a message!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        form
            +++ Section("Message")
            <<< TextAreaRow(){ row in
                row.placeholder = "Enter text here"
            }
            +++ SelectableSection<ListCheckRow<String>>("Department", selectionType: .singleSelection(enableDeselection: true))
            let x = Data.departments
            for option in x {
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
