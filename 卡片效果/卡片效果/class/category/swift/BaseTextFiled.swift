//
//  BaseTextFiled.swift
//  yihuo
//
//  Created by YHIOS on 2020/9/14.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import UIKit

class BaseTextFiled: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }else if(action == #selector(select(_:))){
            
            
        }else if(action == #selector(selectAll(_:))){
            
            
        }
//        let menu = UIMenuController.shared
//        if menu != nil {
//            menu.isMenuVisible = false
//        } // 禁用全部
        
        return super.canPerformAction(action, withSender: sender)
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
