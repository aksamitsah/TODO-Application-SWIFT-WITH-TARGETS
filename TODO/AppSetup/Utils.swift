//
//  Utils.swift
//  TODO
//
//  Created by amit sah on 22/07/22.
//

import Foundation
import UIKit

struct Utils{
    
    public static func dateFormrtter(_ date: Date) -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy h:mm a"
            return dateFormatter.string(from: date)
        }
    
    static func displayAlert(v :AnyObject , _ body: String) {
        
        let  alert = UIAlertController(
            title: nil, message: body, preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        v.present(alert, animated: true)
    }
}

extension UITextField {

   func addDoneButtonOnKeyboard() {
       
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
           target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
           target: self, action: #selector(resignFirstResponder))
       doneButton.tintColor = .black
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
   }
    
}

extension Date {
    var millsecoundString: String{
        String(millisecondsSince1970)
    }
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
