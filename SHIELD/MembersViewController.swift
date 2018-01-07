//
//  MembersViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 07/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import UIKit
import Lottie

class MembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var membersTableView: UITableView!
    
    var i = 0
    let animationView = LOTAnimationView(name: "data")

    @IBAction func statusToggle(_ sender: Any) {
        if i%2 == 0{
            animationView?.play()
            print("play")
        }else{
            animationView?.pause()
        }
        i = i+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "members", for: indexPath as IndexPath) as! MembersTableViewCell
        if check[indexPath.row] == 1{
            cell.status.backgroundColor = UIColor.white
        }
        return cell
    }
   
    var check = [1,0,0,1,1,0,1,0,0,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
        membersTableView.delegate = self
        membersTableView.dataSource = self
        animationView?.frame = CGRect(x: -65, y: -77, width: 200, height: 200)
//        animationView?.center = self.animation.center
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopAnimation = true
        animation.addSubview(animationView!)
        animationView?.play()
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
