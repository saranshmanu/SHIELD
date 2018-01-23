//
//  Constants.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation
import UIKit

public class Data {
    
    public static var uid:String = ""
    public static var username:String = ""
    public static var password:String = ""
    public static var name:String = ""
    public static var registrationNumber:String = ""
    public static var departmentCode:String = ""
    public static var designation:String = ""
    public static var phoneNumber:String = ""
    public static var isAdmin:Bool = false
    public static var isAvailable:Bool = false
    public static var isLogged:Bool = false
    public static var messages:[NSDictionary] = []
    public static var tasks:[NSDictionary] = []
    public static var taskCodes:[String] = []
    public static var members:[NSDictionary] = []
    public static var departments:[String] = ["Technical", "Marketing", "Management", "Design", "Outreach", "Projects"]
    public static var designations:[String] = ["Core Commitee Member", "President", "Vice Precident", "Tech Head"]
    
    public static func findCurrentDate() -> String{
        var date = Date()
        var calendar = Calendar.current
        var x = String(calendar.component(.day, from: date)) + " " + Data.findMonth(month: String(calendar.component(.month, from: date))) + " " + String(calendar.component(.year, from: date))
        return x
    }
    public static func findCurrentTime() -> String{
        var date = Date()
        var calendar = Calendar.current
        var x = String(calendar.component(.hour, from: date)) + ":" + String(calendar.component(.minute, from: date)) + ":" + String(calendar.component(.second, from: date))
        return x
    }
    
    public static func findDepartmentName(departmentCode:String) -> String{
        switch departmentCode {
            case "#01": return "Technical"
            case "#02": return "Marketing"
            case "#03": return "Management"
            case "#04": return "Design"
            case "#05": return "Outreach"
            case "#06": return "Projects"
            default: return ""
        }
    }
    public static func findDepartmentCode(code:String) -> String{
        switch code {
            case "Technical": return "#01"
            case "Marketing": return "#02"
            case "Management": return "#03"
            case "Design": return "#04"
            case "Outreach": return "#05"
            case "Projects": return "#06"
            default: return "#07"
        }
    }
    
    public static func findMonth(month:String) -> String{
        switch month {
            case "1": return "January"
            case "2": return "Febuary"
            case "3": return "March"
            case "4": return "April"
            case "5": return "May"
            case "6": return "June"
            case "7": return "July"
            case "8": return "August"
            case "9": return "September"
            case "10": return "October"
            case "11": return "November"
            case "12": return "December"
            default: return "#07"
        }
    }
}


