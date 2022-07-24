//
//  TodoModel.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import Foundation

struct TodoModel{
    static let identifer = "TodoViewControllerID"
}

struct TodoDataModel: Codable{
    var isActive: Bool?
    var updatedAt: Date?
    var createdAt: Date?
    var task: String?
}
