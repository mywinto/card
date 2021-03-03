//
//  NetRequestSave.swift
//  xiaoya
//
//  Created by who on 2021/1/28.
//

import UIKit

class NetRequestSave: NSObject {
    static public func GET(url:String,parameters:[String:String]? = nil,haveData:Bool = true,success:@escaping NetSuccess){
       
        var filename = String(url[url.range(of: "//")!.upperBound ..< url.endIndex])
        filename = String(filename[filename.range(of: "/")!.upperBound ..< filename.endIndex]).replacingOccurrences(of: "/", with: "")
        let path = "\(NSHomeDirectory())/Documents/\(filename).plist"
        if haveData == false {
            do {
                let data2 =   FileManager.default.contents(atPath: path)
                if data2?.isEmpty == false {
                    let data11 = try JSONSerialization.jsonObject(with: data2!, options: .mutableContainers)
                    let model = NetRequestModel.init()
                    model.code = 1002
                    model.dataValue = data11
                    model.dataStr = NSString.init(data: data2!, encoding: String.Encoding.utf8.rawValue)! as String
                    model.msgStr = ""
                    success(model);

                }
            } catch  {
          
            }
        }
        Net.GET(url: url,parameters:parameters).success { (value) in
            let model = value
            if(value.code == 0 && value.dataValue != nil){
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch  {
                    debugPrint(error)
                }
                do {
                    let data1:Data = try JSONSerialization.data(withJSONObject: value.dataValue!, options: [])
                    try data1.write(to:URL.init(string: "file://\(path)")!)
                } catch  {
                    debugPrint(error)
                }
                success(model);

            }else{
                if(haveData == true){
                    do {
                        let data2 =   FileManager.default.contents(atPath: path)
                        if data2?.isEmpty == false {
                            let data11 = try JSONSerialization.jsonObject(with: data2!, options: .mutableContainers)
                            model.code = 1002
                            model.dataValue = data11
                            model.dataStr = NSString.init(data: data2!, encoding: String.Encoding.utf8.rawValue)! as String
                        }
                    } catch  {
                  
                    }
                }
               
                success(model);

            }
            
            
            
            
        }
    }
}
