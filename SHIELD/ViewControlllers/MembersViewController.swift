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

    @IBOutlet weak var viewCard: UIView!
    //    @IBOutlet weak var animation: UIView!
    @IBOutlet weak var membersTableView: UITableView!
    
//    var i = 0

//    @IBAction func statusToggle(_ sender: Any) {
//        if i%2 == 0{
//            animationView?.play()
//            print("play")
//        }else{
//            animationView?.pause()
//        }
//        i = i+1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "members", for: indexPath as IndexPath) as! MembersTableViewCell
        if check[indexPath.row] == 1{
            cell.status.backgroundColor = UIColor.clear
        }
        return cell
    }
   
    var check = [1,0,0,1,1,0,1,0,0,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        membersTableView.delegate = self
        membersTableView.dataSource = self
//        let animationView = LOTAnimationView(name: "data")
//        animationView?.frame = CGRect(x: -65, y: -77, width: 200, height: 200)
////        animationView?.center = self.animation.center
//        animationView?.contentMode = .scaleAspectFill
//        animationView?.loopAnimation = true
//        animation.addSubview(animationView!)
//        animationView?.play()
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
