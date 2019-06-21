//
//  RegisterViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 23/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka

class RegisterViewController: FormViewController {
    
    func initRegistrationForm() {
        form
            +++ Section("User")
            <<< NameRow(){ row in
                row.title = "Name"
                row.placeholder = "Saransh Mittal"
            }
            <<< TextRow(){ row in
                row.title = "Registration Number"
                row.placeholder = "16BCIXXXX"
            }
            <<< PhoneRow(){ row in
                row.title = "Phone Number"
                row.placeholder = "9999111190"
            }
            +++ Section("Credentials")
            <<< EmailRow(){ row in
                row.title = "Email"
                row.placeholder = "user@csed.com"
            }
            <<< PasswordRow(){ row in
                row.title = "Password"
                row.placeholder = "password"
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
    
    func registerUser(name: String, registrationNumber: String, phoneNumber: Int, email: String, password: String, department: String, designation: String) {
        let spinner = UIViewController.displaySpinner(onView: self.view)
        NetworkEngine.Authentication.registration(name: name, registrationNumber: registrationNumber, phoneNumber: phoneNumber, email: email, password: password, department: department, designation: designation, completion: { (success) in
            UIViewController.removeSpinner(spinner: spinner)
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                UIViewController.alert(title: "Oops!", message: "Posting not successfull", view: self)
            }
        })
    }
    
    func cannotSend(title: String, message: String) {
        let spinner = UIViewController.displaySpinner(onView: self.view)
        UIViewController.removeSpinner(spinner: spinner)
        UIViewController.alert(title: title, message: message, view: self)
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if Reachability.isConnectedToNetwork() == false {
            cannotSend(title: "Oops!", message: "You are not connected to the internet")
            return
        }
        if form.allRows[0].baseValue == nil || form.allRows[1].baseValue == nil || form.allRows[2].baseValue == nil || form.allRows[3].baseValue == nil || form.allRows[4].baseValue == nil {
            cannotSend(title: "Oops!", message: "Please enter all the following fields")
            return
        }
        var department = ""
        for i in 5...(14-1) {
            if form.allRows[i].baseValue != nil{
                department = form.allRows[i].baseValue! as! String
            }
        }
        if department == "" {
            cannotSend(title: "Oops!", message: "Please select a department to which you belong!")
            return
        }
        registerUser(
            name: self.form.allRows[0].baseValue! as! String,
            registrationNumber: self.form.allRows[1].baseValue! as! String,
            phoneNumber: Int(self.form.allRows[2].baseValue! as! String)!,
            email: self.form.allRows[3].baseValue! as! String,
            password: form.allRows[4].baseValue! as! String,
            department: department,
            designation: "Core Commitee Member")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRegistrationForm()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
