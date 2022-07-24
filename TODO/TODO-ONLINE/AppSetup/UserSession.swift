//
//  UserSession.swift
//  TODO
//
//  Created by amit sah on 23/07/22.
//

import Foundation

struct UserSession{
    
    let userDefault = UserDefaults.standard
    
    func firstTimeLoad(_ data: Bool){
        userDefault.set(data, forKey: "old_data")
        userDefault.synchronize()
    }
    
    func getFirstTimeLoad() -> Bool {
        return (userDefault.value(forKey: "old_data") ?? false) as! Bool
    }
}
