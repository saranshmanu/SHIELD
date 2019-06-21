//
//  Data.swift
//  SHIELD
//
//  Created by Saransh Mittal on 21/06/19.
//  Copyright © 2019 Saransh Mittal. All rights reserved.
//

import UIKit

public class Data {
    
    public static var messages:[NSDictionary] = []
    public static var tasks:[NSDictionary] = []
    public static var taskCodes:[String] = []
    public static var members:[NSDictionary] = []
    
    public static func findCurrentDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let x = "\(calendar.component(.day, from: date)) \(Constant.findMonth(month: String(calendar.component(.month, from: date)))) \(calendar.component(.year, from: date))"
        return x
    }
    
    public static func findCurrentTime() -> String{
        let date = Date()
        let calendar = Calendar.current
        let x = "\(calendar.component(.hour, from: date)):\(calendar.component(.minute, from: date))"
        return x
    }
    
    class User {
        public static var uid:String                    = ""
        public static var username:String               = ""
        public static var password:String               = ""
        public static var name:String                   = ""
        public static var registrationNumber:String     = ""
        public static var departmentCode:String         = ""
        public static var designation:String            = ""
        public static var phoneNumber:Int               = 0
        public static var isAdmin:Bool                  = false
        public static var isLogged:Bool                 = false
        public static var isAvailable:Bool?
    }
    
    class ThemeColor {
        public static var redColor: UIColor = UIColor.init(red: 222/255, green: 48/255, blue: 63/255, alpha: 1.0)
    }
}
