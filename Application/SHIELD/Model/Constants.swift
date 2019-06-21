//
//  Constants.swift
//  SHIELD
//
//  Created by Saransh Mittal on 22/01/18.
//  Copyright © 2018 Saransh Mittal. All rights reserved.
//

import Foundation

class Constant {
    public static var departmentCount:Int = 6
    
    public static var departments:[String] = [
        "Editorial and Blog",
        "Events, UR and Stratergies",
        "Expansion",
        "General Secretary",
        "Human Resources",
        "Marketing",
        "Public Relations",
        "Startups" ,
        "Technical and Design"
    ]
    
    public static var designations:[String] = [
        "Core Commitee Member",
        "President",
        "Vice Precident",
        "Tech Head"
    ]
    
    public static func findDepartmentName(departmentCode:String) -> String{
        switch departmentCode {
        case "#0": return "Editorial and Blog"
        case "#1": return "Events, UR and Stratergies"
        case "#2": return "Expansion"
        case "#3": return "General Secretary"
        case "#4": return "Human Resources"
        case "#5": return "Marketing"
        case "#6": return "Public Relations"
        case "#7": return "Startups"
        case "#8": return "Technical and Design"
        default: return ""
        }
    }
    public static func findDepartmentCode(code:String) -> String{
        switch code {
        case "Editorial and Blog": return "#0"
        case "Events, UR and Stratergies": return "#1"
        case "Expansion": return "#2"
        case "General Secretary": return "#3"
        case "Human Resources": return "#4"
        case "Marketing": return "#5"
        case "Public Relations": return "#6"
        case "Startups": return "#7"
        case "Technical and Design": return "#8"
        default: return "#9"
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
