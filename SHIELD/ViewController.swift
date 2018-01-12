//
//  ViewController.swift
//  SHIELD
//
//  Created by Saransh Mittal on 21/11/17.
//  Copyright © 2017 Saransh Mittal. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var upcomingMeetingsCollectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        upcomingMeetingsCollectionView.delegate = self
        upcomingMeetingsCollectionView.dataSource = self
        
//        dateView.layer.masksToBounds = false
//        dateView.layer.shadowColor = UIColor.black.cgColor
//        dateView.layer.shadowOpacity = 0.5
//        dateView.layer.shadowOffset = CGSize(width: -1, height: 1)
//        dateView.layer.shadowRadius = 10
//        dateView.layer.shadowPath = UIBezierPath(rect: dateView.bounds).cgPath
//        dateView.layer.shouldRasterize = true
//        dateView.layer.rasterizationScale = UIScreen.main.scale
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingMeetings", for: indexPath) as! upcomingMeetingsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    


}

