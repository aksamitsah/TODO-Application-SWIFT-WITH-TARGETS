//
//  TodoList+CoreDataProperties.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var task: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?

}

extension TodoList : Identifiable {

}
