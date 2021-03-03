//
//  String+Extension.swift
//  yihuo
//
//  Created by YHIOS on 2020/11/4.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import UIKit

class TextAttrModel: NSObject {
    var url = ""
    var name = ""
    var result:NSRange!
    init(url:String,result:NSRange) {
        self.url = url
        self.result = result
    }
    init(url:String,result:NSRange,name:String) {
        self.url = url
        self.result = result
        self.name = name
    }
}
extension String {
    //json数组转模型
    func toJsonArray() -> [NSDictionary] {
        if self.count == 0 {
            return []
        }
        let data = self.data(using: String.Encoding.utf8)
        
        guard let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [NSDictionary] else { return [] }
        //        for people in peoplesArray! {
        ////            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        //        }
        return peoplesArray
        //
    }
    func toJsonDic() -> NSDictionary {
        if self.count == 0 {
            return NSDictionary.init()
        }
        let data = self.data(using: String.Encoding.utf8)
        
        guard let dic = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary else { return NSDictionary.init() }
        //        for people in peoplesArray! {
        ////            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        //        }
        return dic
        //
    }
    func findAllAtWith(textView:UITextView) ->Array<TextAttrModel>{
        let arr = self.findAllAt()
        var attrModels = [TextAttrModel]()
        let str = self
        for item in arr {
            let url:String = textView.textStorage.attribute(NSAttributedString.Key.init("userid"), at: item.range.location, effectiveRange: nil) as? String ?? ""
            attrModels.append(TextAttrModel.init(url: url, result: item.range,name: str.subString(from: item.range.location+1, to:item.range.location + item.range.length-2)))
            
        }
        return attrModels
    }
    
    func findAllAt()->Array<NSTextCheckingResult>{
        
        do {
            let regex = try NSRegularExpression.init(pattern: "@([^@\\s]*)\\s", options: NSRegularExpression.Options.caseInsensitive)
            let arr =   regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange.init(location: 0, length: self.count))
           return arr
        } catch  {
            
        }
        return []
    }
    
    
    
}
