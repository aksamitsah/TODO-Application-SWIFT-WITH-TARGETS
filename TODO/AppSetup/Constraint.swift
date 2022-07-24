//
//  Constraint.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import UIKit
import Foundation

public struct K{
    
    public struct StoryBoard{
        
        static let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        static let lunchScreenStoryBoard = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        
    }
    
    public struct Colors{
        static let secondaryColor = UIColor(named: "secondary")
        static let  primaryColor = UIColor(named: "primary")
    }
    
    public struct Images{
        static let appIcon = UIImage(named: "icon")
        
        static let addIcon = UIImage(named: "ic_add")
        static let updateIcon = UIImage(named: "ic_update")
        static let closeIcon = UIImage(named: "ic_close")
        
        static let checkboxFillIcon = UIImage(named: "ic_checkbox_fill")
        static let checkboxIcon = UIImage(named: "ic_checkbox")
        
    }
}

