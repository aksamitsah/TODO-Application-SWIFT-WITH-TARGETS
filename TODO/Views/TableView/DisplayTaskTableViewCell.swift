//
//  DisplayTaskTableViewCell.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import UIKit

protocol DisplayTaskTableViewCellProtocal{
    func isTaskCompleated(_ index:Int)
}

class DisplayTaskTableViewCell: UITableViewCell {

    var delegate : DisplayTaskTableViewCellProtocal?
    @IBOutlet weak var isTaskCompleatedBtn: UIButton!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mainUI: UIView!{
    didSet{
         mainUI.layer.cornerRadius = 10.0
        }
    }
    
    var data: TodoList?{
        didSet{
            taskName.text = data?.task ?? "Na"
            date.text = Utils.dateFormrtter(data?.updatedAt ?? Date())
            
            if data?.isActive == true{
                isTaskCompleatedBtn.setBackgroundImage(K.Images.checkboxFillIcon, for: .normal)
            }
            else{
                isTaskCompleatedBtn.setBackgroundImage(K.Images.checkboxIcon, for: .normal)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func onTaskCompleated(_ sender: UIButton) {
        delegate?.isTaskCompleated(sender.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    class var reuseIdentifier: String {
        return "ResDisplayTaskTableViewCell"
    }
    
    class var nibName: String {
        return "DisplayTaskTableViewCell"
    }
    
}
