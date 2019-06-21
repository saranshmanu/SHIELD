//
//  DepartmentViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    @IBAction func logoutAction(_ sender: Any) {
        if NetworkEngine.Authentication.logout() == true{
            toHomeScreen()
        } else {
            UIViewController.alert(title: "Oops!", message: "Failed to logout", view: self)
        }
    }
    
    func toHomeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(viewController, animated: true, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DepartmentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        departmentTableView.delegate = self
        departmentTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.departments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "department", for: indexPath as IndexPath) as! DepartmentTableViewCell
        cell.departmentName.text = Constant.departments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
