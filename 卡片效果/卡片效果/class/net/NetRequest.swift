//
//  NetRequest.swift
//  xiaoya
//
//  Created by who on 2021/1/11.
//

import UIKit
import Foundation
import Alamofire
/// Closure type executed when the request is successful
public typealias  NetSuccess = (_ model: NetRequestModel) -> Void
/// Closure type executed when the request is failed
public typealias  NetFailed = (_ error: NetRequestModel) -> Void
/// Closure type executed when monitoring the upload or download progress of a request.
public typealias NetProgressHandler = (Progress) -> Void
/// Defines the various states of network reachability.
public enum  NetReachabilityStatus {
    /// It is unknown whether the network is reachable.
    case unknown
    /// The network is not reachable.
    case notReachable
    /// The connection type is either over Ethernet or WiFi.
    case ethernetOrWiFi
    /// The connection type is a cellular connection.
    case cellular
}

// ============================================================================

/// Reference to `NetRequest.shared` for quick bootstrapping and examples.
public let Net = NetRequest.shared

/// This notification will be sent when you call method `startMonitoring()` to monitor the network
/// and the network status changes.
public let kNetworkStatusNotification = NSNotification.Name("kNetworkStatusNotification")

// ============================================================================

/// `NetRequest`网络请求主类
public class NetRequest {
    public static let shared = NetRequest()
    /// TaskQueue Array for (`Alamofire.Request` & callback)
    private(set) var taskQueue = [NetworkRequest]()
    /// `Session` creates and manages Alamofire's `Request` types during their lifetimes.
    var sessionManager: Alamofire.Session!

    /// Network reachability manager, The first call to method `startMonitoring()` will be initialized.
    var reachability: NetworkReachabilityManager?
    /// The newwork status, `.unknown` by default, You need to call the `startMonitoring()` method
    var networkStatus: NetReachabilityStatus = .unknown

    // MARK: - Core method

    /// Initialization
    /// `private` for singleton pattern
    private init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 20  // Timeout interval
        config.timeoutIntervalForResource = 20  // Timeout interval
        sessionManager = Alamofire.Session(configuration: config)
    }

    /// Creates a `DataRequest` from a `URLRequest` created using the passed components
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    /// - Returns:  The created `DataRequest`.
    public func request(url: String,
                        method: HTTPMethod = .get,
                        parameters: [String: Any],
                        headers: [String: String]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default) -> NetworkRequest {
        let task = NetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        var response1: AFDataResponse<Any>?
        let dispatchGroup = DispatchGroup.init()
                //创建并发队列
        let concurrentQueue = DispatchQueue.init(label: "com.mutableNetwork.xiaoyanet", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        dispatchGroup.enter()
//        weak var this = self
        concurrentQueue.async {
            task.request = self.sessionManager.request(url,
                                                  method: method,
                                                  parameters: parameters,
                                                  encoding: encoding,
                                                  headers: h).validate().responseJSON { response in
                                                    response1 = response
                                                    dispatchGroup.leave()

                   
                   }
      
                self.taskQueue.append(task)

                }
        //线程通知的方式等待任务组完成---回到主线程中处理数据
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    task.handleResponse(response: response1!)
                    if let index = self.taskQueue.firstIndex(of: task) {
                        self.taskQueue.remove(at: index)
                    }
                }
       
        return task
    }

    /// Creates a `UploadRequest` from a `URLRequest` created using the passed components
    ///
    /// - Parameters:
    ///   - method: `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - parameters: 为了方便格式化参数，采用了[String: String]格式. `nil` by default.
    ///   - datas: Data to upload. The data is encapsulated here! more see `HWMultipartData`
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    /// - Returns: The created `UploadRequest`.
    public func upload(url: String,
                       method: HTTPMethod = .post,
                       parameters: [String: String]?,
                       datas: [HWMultipartData],
                       headers: [String: String]? = nil) -> NetworkRequest {
        let task = NetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }

        task.request = sessionManager.upload(multipartFormData: { (multipartData) in
            // 1.参数 parameters
            if let parameters = parameters {
                for p in parameters {
                    multipartData.append(p.value.data(using: .utf8)!, withName: p.key)
                }
            }
            // 2.数据 datas
            for d in datas {
                multipartData.append(d.data, withName: d.name, fileName: d.fileName, mimeType: d.mimeType)
            }
        }, to: url, method: method, headers: h).uploadProgress(queue: .main, closure: { (progress) in
            task.handleProgress(progress: progress)
        }).validate().responseJSON(completionHandler: { [weak self] response in
            task.handleResponse(response: response)

            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        })
        taskQueue.append(task)
        return task
    }

    /// Creates a `DownloadRequest`...
    ///
    /// - warning: Has not been implemented
    /// - Returns: The created `DownloadRequest`.
    public func download(url: String, method: HTTPMethod = .post) -> NetworkRequest {
        // has not been implemented
        fatalError("download(...) has not been implemented")
    }

    // MARK: - Cancellation

    /// Cancel all active `Request`s, optionally calling a completion handler when complete.
    ///
    /// - Note: This is an asynchronous operation and does not block the creation of future `Request`s. Cancelled
    ///         `Request`s may not cancel immediately due internal work, and may not cancel at all if they are close to
    ///         completion when cancelled.
    ///
    /// - Parameters:
    ///   - queue:      `DispatchQueue` on which the completion handler is run. `.main` by default.
    ///   - completion: Closure to be called when all `Request`s have been cancelled.
    public func cancelAllRequests(completingOnQueue queue: DispatchQueue = .main, completion: (() -> Void)? = nil) {
        sessionManager.cancelAllRequests(completingOnQueue: queue, completion: completion)
    }
}

/// Shortcut method for `NetRequest`
extension NetRequest {

    /// Creates a POST request
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func POST(url: String, parameters: [String: String]? = nil, headers: [String: String]? = nil) -> NetworkRequest {
        let requestModel = SecureTool.getStrEncryptWidthParams(parameters)
        return request(url: url, method: .post, parameters: (requestModel?.params ?? [:]) as! [String : Any], headers: nil)
    }

    /// Creates a POST request for upload data
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func POST(url: String, parameters: [String: String]? = nil, headers: [String: String]? = nil, datas: [HWMultipartData]? = nil) -> NetworkRequest {
        guard datas != nil else {
            return request(url: url, method: .post, parameters: parameters ?? [:], headers: nil)
        }
        return upload(url: url, parameters: parameters, datas: datas!, headers: headers)
    }

    /// Creates a GET request
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    public func GET(url: String, parameters: [String: String]? = nil, headers: [String: String]? = nil) -> NetworkRequest {
        let requestModel = SecureTool.getStrEncryptWidthParams(parameters )
        debugPrint(url)
        debugPrint(parameters ?? "")
        return request(url: url, method: .get, parameters: (requestModel?.params ?? [:]) as! [String : Any], headers: nil)
    }
}

/// Detect network status 监听网络状态
extension NetRequest {
    /// Starts monitoring for changes in network reachability status.
    public func startMonitoring() {
        if reachability == nil {
            reachability = NetworkReachabilityManager.default
        }

        reachability?.startListening(onQueue: .main, onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .notReachable:
                self.networkStatus = .notReachable
            case .unknown:
                self.networkStatus = .unknown
            case .reachable(.ethernetOrWiFi):
                self.networkStatus = .ethernetOrWiFi
            case .reachable(.cellular):
                self.networkStatus = .cellular
            }
            // Sent notification
            NotificationCenter.default.post(name: kNetworkStatusNotification, object: nil)
            debugPrint("NetRequest Network Status: \(self.networkStatus)")
        })
    }

    /// Stops monitoring for changes in network reachability status.
    public func stopMonitoring() {
        guard reachability != nil else { return }
        reachability?.stopListening()
    }
}


/// RequestTask
public class NetworkRequest: Equatable {

    /// Alamofire.DataRequest
    var request: Alamofire.Request?
    /// API description information. default: nil
    var description: String?
    /// API additional information, eg: Author | Note...,  default: nil
    var extra: String?

    /// request response callback
    private var successHandler: NetSuccess?
    /// request failed callback
    private var failedHandler: NetFailed?
    /// `ProgressHandler` provided for upload/download progress callbacks.
    private var progressHandler: NetProgressHandler?

    // MARK: - Handler

    /// Handle request response
    func handleResponse(response: AFDataResponse<Any>) {
        switch response.result {
        case .failure(let error):
            if let closure = successHandler {
                let hwe = NetRequestModel.init()
                let code = error.responseCode ?? 1
                hwe.code = code
                hwe.errorStr = error.localizedDescription
                closure(hwe)
            }
        case .success(let JSON):
            if let closure = successHandler {
                var hwe = NetRequestModel.init()
                if JSON is NSDictionary {
                    hwe = NetRequestModel.deserialize(from: JSON as? NSDictionary) ?? NetRequestModel.init()
                }else{
                    hwe.data = JSON
                }
                closure(hwe)
            }
        }
        clearReference()
    }

    /// Processing request progress (Only when uploading files)
    func handleProgress(progress: Foundation.Progress) {
        if let closure = progressHandler {
            closure(progress)
        }
    }

    // MARK: - Callback

    /// Adds a handler to be called once the request has finished.
    ///
    /// - Parameters:
    ///   - closure: A closure to be executed once the request has finished.
    ///
    /// - Returns:             The request.
    @discardableResult
    public func success(_ closure: @escaping NetSuccess) -> Self {
        successHandler = closure
        return self
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - Parameters:
    ///   - closure: A closure to be executed once the request has finished.
    ///
    /// - Returns:             The request.
    @discardableResult
    public func failed(_ closure: @escaping NetSuccess) -> Self {
        failedHandler = closure
        return self
    }

    /// Sets a closure to be called periodically during the lifecycle of the instance as data is sent to the server.
    ///
    /// - Note: Only the last closure provided is used.
    ///
    /// - Parameters:
    ///   - closure: The closure to be executed periodically as data is sent to the server.
    ///
    /// - Returns:   The instance.
    @discardableResult
    public func progress(closure: @escaping NetProgressHandler) -> Self {
        progressHandler = closure
        return self
    }

    /// Cancels the instance. Once cancelled, a `Request` can no longer be resumed or suspended.
    ///
    /// - Returns: The instance.
    func cancel() {
        request?.cancel()
    }

    /// Free memory
    func clearReference() {
        successHandler = nil
        failedHandler = nil
        progressHandler = nil
    }
}

/// Equatable for `NetworkRequest`
extension NetworkRequest {
    /// Returns a Boolean value indicating whether two values are equal.
    public static func == (lhs: NetworkRequest, rhs: NetworkRequest) -> Bool {
        return lhs.request?.id == rhs.request?.id
    }
}
