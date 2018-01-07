//
//  ViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 21/11/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var dateView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "message", for: indexPath as IndexPath) as! messageTableViewCell
        return cell
    }

    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var sample: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view, typically from a nib.
//        let animationView = LOTAnimationView(name: "preloader")
//        self.view.addSubview(animationView!)
//        animationView?.loopAnimation = true
//        animationView?.play()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

