//
//  ProfileViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 08/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    var check = [1,0,0,1,1,0,1,0,0,1]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workTableView.dequeueReusableCell(withIdentifier: "work", for: indexPath as IndexPath) as! ProfileTableViewCell
        if check[indexPath.row] == 1{
            cell.status.backgroundColor = UIColor.white
        }
        return cell
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var workTableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        workTableView.delegate = self
        workTableView.dataSource = self
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        dropShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dropShadow() {
        infoView.layer.masksToBounds = false
        infoView.layer.shadowColor = UIColor.black.cgColor
        infoView.layer.shadowOpacity = 0.7
        infoView.layer.shadowOffset = CGSize(width: -1, height: 1)
        infoView.layer.shadowRadius = 10
        infoView.layer.shadowPath = UIBezierPath(rect: infoView.bounds).cgPath
        infoView.layer.shouldRasterize = true
        infoView.layer.rasterizationScale = UIScreen.main.scale
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
