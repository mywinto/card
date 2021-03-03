//
//  swiftheader.swift
//  易火
//
//  Created by YHIOS on 2020/5/26.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import Foundation
//@_exported import Kingfisher
   
let kScreenWidth = UIScreen.main.bounds.size.width

let kScreenHeight = UIScreen.main.bounds.size.height

let kVScreenWidth = kScreenWidth > kScreenHeight ?  kScreenHeight :  kScreenWidth

let kVScreenHeight =  kScreenWidth > kScreenHeight ? kScreenWidth : kScreenHeight

let kFontProportion:Double = Double(round((kVScreenWidth > 500 ? 500 : kVScreenWidth) / 375.0 * 100)/100.0 )

let kProportion:Double = Double(round(kVScreenWidth / 375.0 * 100 / 100.0) )

@_exported import FlexLayout

let isPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

let isPad = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

let isiPhoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? Int(UIScreen.main.currentMode!.size.height/UIScreen.main.currentMode!.size.width*100) == 216:false as Bool
//    Bool(kScreenWidth >= 375.0 && kScreenHeight >= 812.0 && isPhone)

#if DEBUG

let isNoDebug = UserDefaults.standard.bool(forKey: IosIsPortNoDebug)
let isDebugUrl = UserDefaults.standard.string(forKey: IosIsPortDebugUrl) ?? ""

let APPISDEBUG = true


let BasePortUrl = isDebugUrl.count > 1 ? isDebugUrl : BaseCommonPortUrl
let BasePortWebUrl = "http://192.168.3.242:8081"
#else
let APPISDEBUG = false
let isDebugUrl = ""

let BasePortUrl = ""
let BasePortWebUrl = ""

#endif


func AllBasePortUrl(_ api:String) -> String{
    return BasePortUrl + api
}

func AutoSizeFromWidth(size:CGFloat) -> CGFloat{
    return round(size * CGFloat(kFontProportion) )
}
func AutoWidthSizeFromWidth(size:CGFloat) -> CGFloat{
    return round(size * CGFloat(kProportion) )
}


let kBottomSafeHeight = CGFloat(isiPhoneX ? 20 : 0)


//

public enum IphoneModel {

case iPhone_4

case iPhone_5

case iPhone_6

case iPhone_Plus

case iPhone_X

case iPhone_XR

}

enum JudgeType {

case Less

case Equal

case Greater

    case Less_Equal

    case Greater_Equal

}

//版本

let SYSTEM_VERSION : String = UIDevice.current.systemVersion

let SYSTEM_VERSION_FLOAT : Float = Float(SYSTEM_VERSION)!

//判断版本

func IS_EQUAL_IOS (version: Float) -> Bool {

return (SYSTEM_VERSION_FLOAT == version)

}

func IS_GREATER_IOS (version: Float) -> Bool{

return (SYSTEM_VERSION_FLOAT > version)

}

func IS_LESS_IOS (version: Float) -> Bool{

return (SYSTEM_VERSION_FLOAT < version)

}

func IS_GREATER_EQUAL_IOS (version: Float) -> Bool{

return (SYSTEM_VERSION_FLOAT >= version)

}

func IS_LESS_EQUAL_IOS (version: Float) -> Bool{

return (SYSTEM_VERSION_FLOAT <= version)

}

// 屏幕宽高

let SCREEN_WIDTH : CGFloat = min(UIScreen.main.bounds.width,UIScreen.main.bounds.height)

let SCREEN_HEIGHT : CGFloat = max(UIScreen.main.bounds.width,UIScreen.main.bounds.height)

func IS_IPHONE_INCH (model: IphoneModel, judge : JudgeType) -> Bool{

switch model {

case .iPhone_4:

switch judge {

case .Less:return SCREEN_WIDTH < 480

case .Equal:return SCREEN_WIDTH == 480

case .Greater:return SCREEN_WIDTH > 480

case .Less_Equal:return SCREEN_WIDTH <= 480

case .Greater_Equal:return SCREEN_WIDTH >= 480

}

case .iPhone_5:

switch judge {

case .Less:return SCREEN_WIDTH < 568

case .Equal:return SCREEN_WIDTH == 568

case .Greater:return SCREEN_WIDTH > 568

case .Less_Equal:return SCREEN_WIDTH <= 568

case .Greater_Equal:return SCREEN_WIDTH >= 568

}

case .iPhone_6:

switch judge {

case .Less:return SCREEN_WIDTH < 667

case .Equal:return SCREEN_WIDTH == 667

case .Greater:return SCREEN_WIDTH > 667

case .Less_Equal:return SCREEN_WIDTH <= 667

case .Greater_Equal:return SCREEN_WIDTH >= 667

}

case .iPhone_Plus:

switch judge {

case .Less:return SCREEN_WIDTH < 736

case .Equal:return SCREEN_WIDTH == 736

case .Greater:return SCREEN_WIDTH > 736

case .Less_Equal:return SCREEN_WIDTH <= 736

case .Greater_Equal:return SCREEN_WIDTH >= 736

}

case .iPhone_X:

switch judge {

case .Less:return SCREEN_WIDTH < 812

case .Equal:return SCREEN_WIDTH == 812

case .Greater:return SCREEN_WIDTH > 812

case .Less_Equal:return SCREEN_WIDTH <= 812

case .Greater_Equal:return SCREEN_WIDTH >= 812

}

case .iPhone_XR:

switch judge {

case .Less:return SCREEN_WIDTH < 896

case .Equal:return SCREEN_WIDTH == 896

case .Greater:return SCREEN_WIDTH > 896

case .Less_Equal:return SCREEN_WIDTH <= 896

case .Greater_Equal:return SCREEN_WIDTH >= 896

}

}

}

func STATUS_BAR_HEIGHT() -> CGFloat{
    return UIApplication.shared.statusBarFrame.size.height
    
if IS_IPHONE_INCH(model: .iPhone_X, judge: .Greater_Equal) {return 44.0 }else {return 20.0}

}

let NAV_BAR_HEIGHT: CGFloat = STATUS_BAR_HEIGHT() + 44.0

func SAFE_BOTTOM_HEIGHT() -> CGFloat{
    if #available(iOS 11.0, *) {
        return  UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    } else {
        return 0 
        // Fallback on earlier versions
    }

//if IS_IPHONE_INCH(model: .iPhone_X, judge: .Greater_Equal) {return 34.0 }else {return 0.0}

}

let TAB_BAR_HEIGHT: CGFloat = SAFE_BOTTOM_HEIGHT() + 49.0

/// 一般界面的高度

let VIEW_HEIGHT: CGFloat = SCREEN_HEIGHT - NAV_BAR_HEIGHT - SAFE_BOTTOM_HEIGHT()

/// 相对于 750 宽的屏幕比例

let SCREEN_WIDTH_SCALE_47: CGFloat = SCREEN_WIDTH/375.0

let SCREEN_HEIGHT_SCALE_47: CGFloat = SCREEN_HEIGHT/667.0

/// RGBA的颜色设置

func RGB(_ r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {

return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)

}

func RGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {

return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)

}

func RGBS(_ s:CGFloat) -> UIColor {

    return UIColor(red: s / 255.0, green: s / 255.0, blue: s / 255.0, alpha: 1.0)

}

func HEXA(hexValue: Int, a: CGFloat) -> (UIColor) {

    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,

                         green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,

                                                                                                                                                                                                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,alpha: a)

}
func KSUIColorFromRGB( hexValue: Int) -> (UIColor) {
    let hexValuec = hexValue
    return UIColor(red: ((CGFloat)((hexValuec & 0xFF0000) >> 16)) / 255.0,

                         green: ((CGFloat)((hexValuec & 0xFF00) >> 8)) / 255.0,

                                                                                                                                                                                                       blue: ((CGFloat)(hexValuec & 0xFF)) / 255.0,alpha: 1)

}
func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count == 3){
            cString += cString
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

func HEX(hexValue: Int) -> (UIColor) {
    

    return HEXA(hexValue: hexValue, a: 1.0)

}

//便利化 UserDefaults

let kUserDefaults: UserDefaults = UserDefaults.standard

//便利化 AppDelegate

//let kAppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

//便利化 Notification

let kNotification: NotificationCenter = NotificationCenter.default

func kNotificationPost (name: String){

kNotification.post(name: NSNotification.Name(rawValue: name), object: nil)

}

//便利化 获取图片资源

func kGetImage(name: String) -> (UIImage)? {

return UIImage.init(named: name)

}

//便利化 字体

func kBoldSystemFont(font: CGFloat) -> (UIFont) {

return UIFont.boldSystemFont(ofSize: font)

}

func kSystemFont(font: CGFloat) -> (UIFont) {

return UIFont.systemFont(ofSize: font)

}

//便利化 通过Storyboard ID 在对应Storyboard中获取场景对象

func kVCFromSb(name: String,identifier: String) -> (UIViewController) {

    let storyBoard = UIStoryboard.init(name: name, bundle: nil)

    let vc = storyBoard.instantiateViewController(withIdentifier: identifier)

    return vc

}

func kScaleFrom_iPhone5_Desgin(_ x:CGFloat) -> CGFloat {

    return (x * (SCREEN_WIDTH/320))

}

func kScaleFrom_iPhone6_Desgin(_ x:CGFloat) -> CGFloat {

    return (x * (SCREEN_WIDTH/375))

}

func kScaleFrom_iPhone6_Margin_Desgin(_ x:CGFloat, m:CGFloat) -> CGFloat {

    return (x * ((SCREEN_WIDTH-m)/(375-m)))

}
func isCKDarkMode()->Bool{
    if #available(iOS 13.0, *) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            return true
        }
    }
    return false
}


//func dPrint(@autoclosure item: () -> Any) {

struct Log {
    
    static func debug<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
            //获取文件名
            let fileName = (file as NSString).lastPathComponent
            //打印日志内容
            print("Debug: \(fileName):\(line) \(function) | \(message)")
        #endif
    }
}
