//
//  Extensions.swift
//  SHIELD
//
//  Created by Saransh Mittal on 21/06/19.
//  Copyright © 2019 Saransh Mittal. All rights reserved.
//

import UIKit

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loader = UIActivityIndicatorView.init(style: .whiteLarge)
        loader.startAnimating()
        loader.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(loader)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    class func alert(title: String, message: String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true)
    }
}
