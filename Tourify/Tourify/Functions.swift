//
//  Functions.swift
//  Tourify
//
//  Created by 顾悦平 on 11/8/23.
//

import Foundation
import UIKit
// useful functions
func generateAlert(t:String, msg:String) -> UIAlertController{
    let response = "OK"
    let res = NSLocalizedString(response, tableName: "Main", bundle: .main, value: response, comment: response)
    let popAlert = UIAlertController(title:t, message: msg,preferredStyle: .alert)
        popAlert.addAction(UIAlertAction(title:res, style: UIAlertAction.Style.default))
    return popAlert
//    self.present(popAlert, animated: true, completion: nil)
    }


