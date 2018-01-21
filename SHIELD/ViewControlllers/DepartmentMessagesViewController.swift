//
//  DepartmentMessagesViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 12/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class DepartmentMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.tintColor = .white
        // Do any additional setup after loading the view.
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "departmentMessage", for: indexPath as IndexPath) as! departmentMessagesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .black
        UIApplication.shared.statusBarStyle = .lightContent
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
