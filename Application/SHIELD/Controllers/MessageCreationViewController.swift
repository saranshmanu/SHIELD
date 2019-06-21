//
//  MessageCreationViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka

class MessageCreationViewController: FormViewController {
    
    func initMessageCreationForm() {
        form
            +++ Section("Message")
            <<< TextAreaRow(){ row in
                row.placeholder = "Enter text here"
            }
            +++ SelectableSection<ListCheckRow<String>>("Department", selectionType: .singleSelection(enableDeselection: true))
        let x = Constant.departments
        for option in x {
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
            cannotSend(title: "Oops!", message: "Message is empty!")
            return
        }
        var department = ""
        for i in 1...(10-1){
            if form.allRows[i].baseValue != nil{
                department = form.allRows[i].baseValue! as! String
            }
        }
        if department == ""{
            cannotSend(title: "Oops!", message: "Select a department to post the message!")
            return
        }
        let message = form.allRows[0].baseValue! as! String
        NetworkEngine.User.createMessage(message: message, department: department) { (success) in
            if success {
                let spinner = UIViewController.displaySpinner(onView: self.view)
                UIViewController.removeSpinner(spinner: spinner)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.cannotSend(title: "Oops!", message: "Message failed to get delivered!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMessageCreationForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
