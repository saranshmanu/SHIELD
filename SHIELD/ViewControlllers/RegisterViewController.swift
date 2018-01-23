//
//  RegisterViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 23/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class RegisterViewController: FormViewController {

    public func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if form.allRows[0].baseValue != nil || form.allRows[1].baseValue != nil || form.allRows[2].baseValue != nil || form.allRows[3].baseValue != nil || form.allRows[4].baseValue != nil{
        } else {
            //perform an alert that the message field is empty
            alert(title: "Oops!", message: "Please enter all the following fields")
            return
        }
        var department = ""
        for i in 5...Data.departments.count-1{
            if form.allRows[i].baseValue != nil{
                department = form.allRows[i].baseValue! as! String
            }
        }
        if department == ""{
            // perform an alert that the department is not selected
            alert(title: "Oops!", message: "Please select a department to which you belong!")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: form.allRows[3].baseValue! as! String, password: form.allRows[4].baseValue! as! String) { (user, error) in
            if error == nil {
                var register = [
                    "name": self.form.allRows[0].baseValue! as! String,
                    "registrationNumber":self.form.allRows[1].baseValue! as! String,
                    "phoneNumber":self.form.allRows[2].baseValue! as! String,
                    "email":self.form.allRows[3].baseValue! as! String,
                    "department":department,
                    "isAdmin":"0",
                    "designation":"Core Commitee Member"
                ]
                FIRDatabase.database().reference().child("member").setValue(register)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                //create an alert that registration was not successfull
                self.alert(title: "Oops!", message: "Registration not successfull")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
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
                row.placeholder = "16BCIXXXX"
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
