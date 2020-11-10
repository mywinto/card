//
//  FlexTestVC.swift
//  卡片效果
//
//  Created by YHIOS on 2020/10/29.
//  Copyright © 2020 CES. All rights reserved.
//

import UIKit

class FlexTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let text = UITextView.init(frame: CGRect(x: 100, y: 500, width: 300, height: 50))
        text.text = " lakjflja"
        self.view.addSubview(text)
        text.isEditable = false;
        text.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click(tap:))))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func click(tap:UITapGestureRecognizer){
        (tap.view as! UITextView).selectAll(self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
