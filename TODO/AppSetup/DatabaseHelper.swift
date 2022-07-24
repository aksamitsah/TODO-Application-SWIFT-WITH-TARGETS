//
//  DatabaseHelper.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func set(task: String) -> Bool{
        let todoList = NSEntityDescription.insertNewObject(forEntityName: "TodoList", into: context!) as! TodoList
        todoList.task = task
        todoList.isActive = false
        todoList.createdAt = Date()
        todoList.updatedAt = Date()
        
        do{
            try context?.save()
            print("saved data sucess")
            
        }catch{
            print("failed to save data")
            return false
        }
        return true
    }
    
    func setAll(taskAll: [TodoDataModel]) -> Bool{
        for data in taskAll {
            let todoList = NSEntityDescription.insertNewObject(forEntityName: "TodoList", into: context!) as! TodoList
            todoList.task = data.task
            todoList.isActive = data.isActive ?? false
            todoList.createdAt = data.createdAt
            todoList.updatedAt = data.updatedAt

            do{
                try context?.save()
                print("saved data sucess")
                
            }catch{
                print("failed to save data")
                return false
            }
        }
        return true
    }
    
    func get() -> [TodoList]{
        var data = [TodoList]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TodoList")
        do{
            data = try context?.fetch(fetchRequest) as! [TodoList]
        }catch{
            print("cant fetch something want wrong")
        }
        return data
    }
    
    func delete(index: Int){
        var data = get()
        context?.delete(data[index])
        data.remove(at: index)
        do{
            try context?.save()
        }catch{
            print("cant delete data try again")
            return
        }
    }
    
    func update(task: String,index: Int) -> Bool{
        let data = get()
        
        if task == data[index].task{
            return false
        }
        
        data[index].task = task
        data[index].updatedAt = Date()
        
        do{
            try context?.save()
        }catch{
            print("cant update data try again")
            return false
        }
        return true
    }
    
    func update(index: Int) -> Bool{
        let data = get()
        data[index].isActive = !data[index].isActive
        data[index].updatedAt = Date()
        do{
            try context?.save()
        }catch{
            print("cant update data try again")
            return false
        }
        return true
    }
}
