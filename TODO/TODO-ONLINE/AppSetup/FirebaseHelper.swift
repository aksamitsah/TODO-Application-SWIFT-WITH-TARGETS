//
//  FirebaseHelper.swift
//  TODO
//
//  Created by amit sah on 23/07/22.
//
import Foundation
import Firebase
import CodableFirebase
import UIKit

class FirebaseHelper{
    
    static var sharedInstance = FirebaseHelper()
    
    let ref: DatabaseReference = Database.database().reference().child("TODO-LIST").child(UIDevice.current.identifierForVendor!.uuidString)
    
    //First Time Load Rebember Your Device Data Found
    func get(){
        
        var taskList = [TodoDataModel]()
        
        if Reachability.isConnectedToNetwork(){
            UserSession().firstTimeLoad(true)
        }
        else{
            return
        }
        ref.getData(completion:  { error, snapshot in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let value = snapshot?.value else { return }
            print(value)
            
            for child in (snapshot?.children.allObjects as! [DataSnapshot]) {
                do {
                    let model: TodoDataModel = try FirebaseDecoder().decode(TodoDataModel.self, from: child.value!)
                    taskList.append(model)
                    
                } catch let error {
                    print(error)
                }
            }
            if taskList.count < 1{
                return
            }
            if DatabaseHelper.sharedInstance.setAll(taskAll: taskList){
                print("sync Sucessfull")
            }
        });
    }
    
    func set(data: TodoList){
        
        let encodeData = try! FirebaseEncoder().encode(TodoDataModel(isActive: data.isActive, updatedAt: data.updatedAt, createdAt: data.createdAt, task: data.task))
        
        if let node = data.createdAt?.millsecoundString{
            ref.child(node).setValue(encodeData)
        }
    }
    
    func update(data: TodoList){
        
        let encodeData = try! FirebaseEncoder().encode(TodoDataModel(isActive: data.isActive, updatedAt: data.updatedAt, createdAt: data.createdAt, task: data.task))
       
        if let node = data.createdAt?.millsecoundString{
            ref.child(node).setValue(encodeData)
        }
    }
        
    func remove(data: TodoList){
        if let node = data.createdAt?.millsecoundString{
            ref.child(node).removeValue()
        }
        
    }
    
}
