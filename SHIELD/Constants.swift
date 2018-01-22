//
//  Constants.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation

public class Data {
    
    public static func findCurrentDate() -> String{
        var date = Date()
        var calendar = Calendar.current
        var MONTH:String = "January"
        var DATE = String(calendar.component(.day, from: date)) + " " + Data.findMonth(month: String(calendar.component(.month, from: date))) + " " + String(calendar.component(.year, from: date))
        return DATE
    }
    public static func findCurrentTime() -> String{
        var date = Date()
        var calendar = Calendar.current
        return String(calendar.component(.hour, from: date)) + ":" + String(calendar.component(.minute, from: date)) + ":" + String(calendar.component(.second, from: date))
    }
    
    public static var name:String = "Saransh Mittal"
    public static var registrationNumber:String = "16BCE0642"
    public static var departmentCode:String = "#01"
    public static var designation:String = "Core Committee Member"
    public static var phoneNumber:String = "9910749550"
    public static var isAdmin:Bool = true
    
    public static var departments:[String] = ["Technical", "Marketing", "Management", "Design", "Outreach", "Projects"]
    
    public func findDepartmentName(departmentCode:String) -> String{
        switch departmentCode {
        case "#01":
            return "Technical"
        case "#02":
            return "Marketing"
        case "#03":
            return "Management"
        case "#04":
            return "Design"
        case "#05":
            return "Outreach"
        case "#06":
            return "Projects"
        default:
            return ""
        }
    }
    public static func findDepartmentCode(code:String) -> String{
        switch code {
        case "Technical":
            return "#01"
        case "Marketing":
            return "#02"
        case "Management":
            return "#03"
        case "Design":
            return "#04"
        case "Outreach":
            return "#05"
        case "Projects":
            return "#06"
        default:
            return "#07"
        }
    }
    
    public static func findMonth(month:String) -> String{
        switch month {
        case "1":
            return "January"
        case "2":
            return "Febuary"
        case "3":
            return "March"
        case "4":
            return "April"
        case "5":
            return "May"
        case "6":
            return "June"
        case "7":
            return "July"
        case "8":
            return "August"
        case "9":
            return "September"
        case "10":
            return "October"
        case "11":
            return "November"
        case "12":
            return "December"
        default:
            return "#07"
        }
    }
}


