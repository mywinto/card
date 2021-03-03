//
//  NetRequestOC.swift
//

import UIKit



/// 封装OC调用网络请求
@objc class NetRequestOC: NSObject {

    /// POST请求
    ///
    /// - Parameters:
    ///   - url: 请求的URL，是全地址
    ///   - info: 请求的描述说明，可以为nil，比如: 首页的请求
    ///   - parameters: 请求参数，可能为nil
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - success: 请求成功的响应回调
    ///   - failed: 请求失败的响应回调
    @objc static func POST(_ url: String, info: String?, parameters: [String: String]?, headers: [String: String]?, success: @escaping (_ model:NetRequestModelOC)->Void) {
      
        Net.POST(url: url, parameters: parameters, headers: headers).success{
            model in
            let ocmodel = NetRequestModelOC.init(code: model.code, data: model.data, dataStr: model.dataStr, msgStr: model.msgStr, errorStr: model.errorStr)
            success(ocmodel)
        }.description = info
    }

    @objc static func POST(_ url: String, info: String?, parameters: [String: String]?, success: @escaping (_ model:NetRequestModelOC)->Void) {
        Net.POST(url: url, parameters: parameters, headers: nil).success { model in
            let ocmodel = NetRequestModelOC.init(code: model.code, data: model.data, dataStr: model.dataStr, msgStr: model.msgStr, errorStr: model.errorStr)
            success(ocmodel)
        }.description = info
    }

    /// GET请求
    ///
    /// - Parameters:
    ///   - url: 请求的URL，是全地址
    ///   - info: 请求的描述说明，可以为nil，比如: 首页的请求
    ///   - parameters: 请求参数，可能为nil
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - success: 请求成功的响应回调
    ///   - failed: 请求失败的响应回调
    @objc static func GET(_ url: String, info: String?, parameters: [String: String]?, headers: [String: String]?, success: @escaping (_ model:NetRequestModelOC)->Void) {
        Net.GET(url: url, parameters: parameters, headers: headers).success { model in
            let ocmodel = NetRequestModelOC.init(code: model.code, data: model.data, dataStr: model.dataStr, msgStr: model.msgStr, errorStr: model.errorStr)
            success(ocmodel)
        }.description = info
    }

    @objc static func GET(_ url: String, info: String?, parameters: [String: String]?, success: @escaping (_ model:NetRequestModelOC)->Void) {
        Net.GET(url: url, parameters: parameters, headers: nil).success { model in
            let ocmodel = NetRequestModelOC.init(code: model.code, data: model.data, dataStr: model.dataStr, msgStr: model.msgStr, errorStr: model.errorStr)
            success(ocmodel)
        }.description = info
    }

    @objc static func GET(_ url: String, info: String?, success: @escaping  (_ model:NetRequestModelOC)->Void) {
        Net.GET(url: url, parameters: nil, headers: nil).success { model in
            let ocmodel = NetRequestModelOC.init(code: model.code, data: model.data, dataStr: model.dataStr, msgStr: model.msgStr, errorStr: model.errorStr)
            success(ocmodel)
        }.description = info
    }
}
