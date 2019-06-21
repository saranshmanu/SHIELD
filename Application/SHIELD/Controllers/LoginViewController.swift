//
//  LoginViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 23/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottonConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    func loginUser(username: String, password: String) {
        initLogin(completed: false)
        NetworkEngine.Authentication.login(username: username, password: password) { (success) in
            self.initLogin(completed: true)
            if success {
                self.dismiss(animated: true, completion: nil)
                NetworkEngine.User.loadData()
            } else {
                UIViewController.alert(title: "Oops!", message: "The credentials entered are invalid", view: self)
            }
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loginUser(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    var constant:CGFloat = 180.0
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.27) {
            self.topConstraint.constant -= self.constant
            self.bottonConstraint.constant += self.constant
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(self.usernameTextField.isEditing || self.passwordTextField.isEditing) {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.27, animations: {
                self.topConstraint.constant += self.constant
                self.bottonConstraint.constant -= self.constant
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func initLogin(completed: Bool) {
        usernameTextField.isEnabled = completed
        passwordTextField.isEnabled = completed
        loginButton.isEnabled = completed
        loader.isHidden = completed
        if completed {
            loader.stopAnimating()
        } else {
            loader.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
