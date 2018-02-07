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
        let sv = UIViewController.displaySpinner(onView: self.view)
        if Reachability.isConnectedToNetwork(){
            // connected to the internet
            if form.allRows[0].baseValue != nil || form.allRows[1].baseValue != nil || form.allRows[2].baseValue != nil || form.allRows[3].baseValue != nil || form.allRows[4].baseValue != nil{
            } else {
                //perform an alert that the message field is empty
                UIViewController.removeSpinner(spinner: sv)
                alert(title: "Oops!", message: "Please enter all the following fields")
                return
            }
            var department = ""
            for i in 5...(11-1){
                if form.allRows[i].baseValue != nil{
                    department = form.allRows[i].baseValue! as! String
                }
            }
            if department == ""{
                // perform an alert that the department is not selected
                UIViewController.removeSpinner(spinner: sv)
                alert(title: "Oops!", message: "Please select a department to which you belong!")
                return
            }
            FIRAuth.auth()?.createUser(withEmail: form.allRows[3].baseValue! as! String, password: form.allRows[4].baseValue! as! String) { (user, error) in
                if error == nil {
                    var register = [
                        "name": self.form.allRows[0].baseValue! as! String,
                        "registrationNumber":self.form.allRows[1].baseValue! as! String,
                        "phoneNumber":9910749550,//Int(self.form.allRows[2].baseValue!)
                        "email":self.form.allRows[3].baseValue! as! String,
                        "department":Data.findDepartmentCode(code: department),
                        "isAdmin":0,
                        "available":1,
                        "designation":"Core Commitee Member"
                        ] as [String : Any]
                    FIRDatabase.database().reference().child("member").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(register){
                        (err, resp) in
                        if err == nil{
                            UIViewController.removeSpinner(spinner: sv)
                            self.navigationController?.popToRootViewController(animated: true)
                        } else {
                            UIViewController.removeSpinner(spinner: sv)
                            self.alert(title: "Oops!", message: "Posting not successfull")
                        }
                    }
                } else {
                    //create an alert that registration was not successfull
                    UIViewController.removeSpinner(spinner: sv)
                    self.alert(title: "Oops!", message: "Registration not successfull")
                }
            }
        }else{
            // not connected to the internet
            UIViewController.removeSpinner(spinner: sv)
            alert(title: "Oops!", message: "You are not connected to the internet")
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
                row.placeholder = "password"
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
