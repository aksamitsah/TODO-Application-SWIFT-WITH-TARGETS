//
//  TodoViewModel.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import Foundation
import UIKit

class TodoViewModel{
    
    weak var vc: TodoViewController?
    var data = [TodoList]()
    
    var isTaskEditing = false
    var seletedEditableIndex: Int?
    
    
    func loadData(){
        data = DatabaseHelper.sharedInstance.get()
        vc?.updateTable()
    }
    
    func addAndUpdateTask(){
        
        guard let task = vc?.txt_main.text, !task.isEmpty else{
            vc?.displayMessage("Please Add Enter Task First")
            return
        }
        
        vc?.txt_main.text = ""
        if isTaskEditing{
            if DatabaseHelper.sharedInstance.update(task: task, index: seletedEditableIndex!){
                loadData()
                isTaskEditable(false, index: 0)
            }
            return
        }
        
        if DatabaseHelper.sharedInstance.set(task: task){
            loadData()
        }
    }
    
    func updateCompleatedTask(_ index: Int){
        if DatabaseHelper.sharedInstance.update(index: index){
            loadData()
        }
    }
    
    func deleteTask(_ index: Int){
        DatabaseHelper.sharedInstance.delete(index: index)
    }
    
    func setupUI(_ txt_main: UITextField){
        
        txt_main.layer.cornerRadius = 15.0
        txt_main.layer.borderWidth = 2.0
        txt_main.layer.borderColor = K.Colors.primaryColor?.cgColor
        txt_main.addDoneButtonOnKeyboard()
        
        isTaskEditable(false, index: 0)
        
    }
    
    func isTaskEditable(_ editable: Bool, index: Int){
        seletedEditableIndex = index
        isTaskEditing = editable
        if editable{
            vc?.back_btn.isHidden = false
            vc?.txt_main.text = data[index].task
            vc?.txt_main.endEditing(false)
            vc?.add_update_btn.setBackgroundImage(K.Images.updateIcon, for: .normal)
        }
        else{
            vc?.back_btn.isHidden = true
            vc?.txt_main.text = ""
            vc?.txt_main.endEditing(true)
            vc?.add_update_btn.setBackgroundImage(K.Images.addIcon, for: .normal)
        }
    }
}
