//
//  NetRequestCommon.swift
//  xiaoya
//
//  Created by who on 2021/2/3.
//

import UIKit

class NetRequestCommon: NSObject {
    static public func commonApiGetGoodsByCommand(){
        let command = UIPasteboard.general.string        
        if (command?.replacingOccurrences(of: " ", with: "").count ?? 0) == 0  {
            return
        }
        Net.GET(url: AllBasePortUrl(GetGoodsByCommand),parameters: ["command":command!]).success { (value) in
            if(value.code == 0 ){
                let code = ((value.dataValue as!NSDictionary)["code"] as? NSNumber)?.intValue ?? 10
                UIPasteboard.general.string = ""
                let vc = XYPasteAlertVC.init()
                if(code == 0){
                    let model = XYGoodModel.deserialize(from: (value.dataValue as! NSDictionary)["item"] as? NSDictionary)
                    vc.model = model!
                }else if(code == 2002){
                    let str = (value.dataValue as! NSDictionary)["title"] as? String ?? ""
                    vc.content = str
                }
              let tab =  CommonTool.getPresentedViewController()
                if tab.presentedViewController == nil {
                    vc.modalPresentationStyle = .overCurrentContext
                    tab.present(vc, animated: false) {
                        
                    }
                }
                
                
            }
            
            
        }
    }
}
