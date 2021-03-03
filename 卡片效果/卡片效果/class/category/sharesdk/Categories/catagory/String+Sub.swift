//
//  1.swift
//  yihuo
//
//  Created by YHIOS on 2020/8/26.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import UIKit

extension String {
    /// 截取到任意位置
    func subString(to: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: to)
        return String(self[..<index])
    }
    /// 从任意位置开始截取
    func subString(from: Int) -> String {
        let index: String.Index = self.index(startIndex, offsetBy: from)
        return String(self[index ..< endIndex])
    }
    /// 从任意位置开始截取到任意位置
    func subString(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
    //使用下标截取到任意位置
    subscript(to: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: to)
        return String(self[..<index])
    }
    //使用下标从任意位置开始截取到任意位置
    subscript(from: Int, to: Int) -> String {
        let beginIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[beginIndex...endIndex])
    }
}
