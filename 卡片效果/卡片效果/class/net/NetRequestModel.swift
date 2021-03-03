//
//  NetRequestModel.swift
//  xiaoya
//
//  Created by who on 2021/1/11.
//

import UIKit

import HandyJSON
class NetRequestModelOC:NSObject{
    @objc var code=1 //1001未登录   0成功  1失败
    @objc var data:Any?
    @objc var dataStr = ""
    @objc var dataValue:[String:Any] = [:]
    @objc var msgStr = "网络连接错误"
    @objc var errorStr = ""
    @objc init(code:Int,data:Any?,dataStr:String,msgStr:String,errorStr:String) {
        self.code = code
        self.data = data
        self.dataStr = dataStr
        self.msgStr = msgStr
        self.errorStr = errorStr
    }
}
class XYDataManager:NSObject{
    static public func setCode(list: Array<Any>?,scrollView:UIScrollView?,VC:BaseViewController?,value:NetRequestModel){
        if (list?.count ?? 1) == 0 {
            if value.code == 0  {
                VC?.dataErrorCodeType = DataErrorCodeTypeNoData
            }else{
                VC?.dataErrorCodeType = DataErrorCodeTypeWifiError
                if value.code == 1 {
                    VC?.noDataTitle = value.msgStr
                }
            }
        }else{
            VC?.dataErrorCodeType = DataErrorCodeTypeNormal
        }
        scrollView?.reloadEmptyDataSet()
        if scrollView is UICollectionView {
            ( scrollView as? UICollectionView)?.reloadData()
        }else if scrollView is UITableView {
            ( scrollView as? UITableView)?.reloadData()
        }
    }
    static public func setCodeNolist(data: Any?,scrollView:UIScrollView?,VC:BaseViewController?,value:NetRequestModel){
        if data == nil {
                VC?.dataErrorCodeType = DataErrorCodeTypeWifiError
                if value.code == 1 {
                    VC?.noDataTitle = value.msgStr
                }
        }else{
            VC?.dataErrorCodeType = DataErrorCodeTypeNormal
        }
        scrollView?.reloadEmptyDataSet()
    }
    static public func setCode1( page:Int,list:inout Array<Any>?,arr:Array<Any>,scrollView:UIScrollView?,VC:BaseViewController?,code:Int){
        if page == 0 {
            list? = []
        }
        list?.append(arr)
        if list?.count == 0 {
            if code == 0  {
                VC?.dataErrorCodeType = DataErrorCodeTypeNoData
            }else{
                VC?.dataErrorCodeType = DataErrorCodeTypeWifiError
            }
        }else{
            VC?.dataErrorCodeType = DataErrorCodeTypeNormal

        }
        scrollView?.reloadEmptyDataSet()
        if scrollView is UICollectionView {
            ( scrollView as? UICollectionView)?.reloadData()
        }else if scrollView is UITableView {
            ( scrollView as? UITableView)?.reloadData()
        }
        
    }
}

public class NetRequestModel:HandyJSON{
    var code=1 //1001未登录   0成功  1失败 1002失败 读取缓存
    var data:Any?
    var dataStr = ""
    var dataValue:Any?
    var msgStr = "网络连接错误"
    var msg = ""
    var errorStr = ""
    public func didFinishMapping() {
        if data is String {
            dataStr = SecureTool.decryptUseDES(data as? String, key: dekey)
            dataValue =  (dataStr as NSString).jsonObject()
            msgStr = msg
            if msg == "userid不能为空" {
                code = 1001
                msgStr = "您还为登录"
            }
        }
        
    }
    required public init() {
        
    }
}
