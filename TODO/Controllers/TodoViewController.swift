//
//  TodoViewController.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import UIKit

class TodoViewController: UIViewController {
    
    var viewModel = TodoViewModel()
    @IBOutlet weak var cloud_btn: UIButton!
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var add_update_btn: UIButton!
    
    @IBOutlet weak var txt_heading: UILabel!
    @IBOutlet weak var txt_main: UITextField!
    
    @IBOutlet weak var table_view: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.setupUI(txt_main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.vc = self
        txt_main.delegate = self
        table_view.delegate = self
        table_view.dataSource = self
        viewModel.loadData()
        
        table_view.register(UINib(nibName: DisplayTaskTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: DisplayTaskTableViewCell.reuseIdentifier)
        
    }
    
    @IBAction func ActionBtn(_ sender: UIButton) {
        viewModel.addAndUpdateTask()
    }
    
    @IBAction func ActionUndo(_ sender: UIButton) {
        viewModel.isTaskEditable(false, index: 0)
    }
    
    func displayMessage(_ message: String){
        Utils.displayAlert(v: self, message)
    }
    
}

extension TodoViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txt_main == textField{
            viewModel.addAndUpdateTask()
        }
        return true
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func updateTable(){
        DispatchQueue.main.async{
            self.table_view.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.isTaskEditable(true, index: indexPath.row)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DisplayTaskTableViewCell.reuseIdentifier, for: indexPath) as! DisplayTaskTableViewCell
      
        cell.data = viewModel.data[indexPath.row]
        cell.isTaskCompleatedBtn.tag = indexPath.row
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            tableView.beginUpdates()
            viewModel.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            viewModel.deleteTask(indexPath.row)
            
        }
    }
}

extension TodoViewController: DisplayTaskTableViewCellProtocal{
    func isTaskCompleated(_ index: Int) {
        viewModel.updateCompleatedTask(index)
    }
}
