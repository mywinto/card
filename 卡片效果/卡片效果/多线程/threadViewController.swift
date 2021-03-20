//
//  threadViewController.swift
//  卡片效果
//
//  Created by YHIOS on 2021/3/15.
//  Copyright © 2021 CES. All rights reserved.
//

import UIKit

class threadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        /// 是否开启了多线程
        var isMultiThreaded = Thread.isMultiThreaded()
        /// 当前线程
        var currentThread = Thread.current
        /// 主线程
        var mainThread = Thread.main
        /// 当前线程休眠5秒
//        Thread.sleep(forTimeInterval: 5)
        /// 线程睡眠到指定时间
//        Thread.sleep(until: Date.init(timeIntervalSinceNow: 5))
        /// 退出当前线程，注意不要在主线程调用，防止主线程被kill掉
//        Thread.exit()
        /** NSThread线程对象基本创建，target为入口函数所在的对象，selector为线程入口函数 **/
        /* 1 线程实例对象创建与设置 */
        let newThread = Thread.init(target: self, selector: #selector(threadClick1), object: nil)
        /* 设置线程优先级threadPriority(0~1.0)，即将被抛弃，将使用qualityOfService代替 */
        newThread.threadPriority = 1.0
        newThread.qualityOfService = .userInteractive
        newThread.start()
        /* 2 静态方法快速创建并开启新线程 */
        for i in 0...10 {
            Thread.detachNewThread {
                print(i)
                
            }
        }
        
        /** NSObejct基类隐式创建线程的一些静态工具方法 **/
           /* 1 在当前线程上执行方法，延迟2s */
        self.perform(#selector(threadClick2), with: nil, afterDelay: 1.0)
        /* 2 在指定线程上执行方法，不等待当前线程 */
        self.perform(#selector(threadClick3), on: newThread, with: nil, waitUntilDone: false)
        /* 3 后台异步执行函数 */
        self.performSelector(inBackground: #selector(threadClick4), with: nil)
        self.performSelector(onMainThread:  #selector(threadClick5), with: nil, waitUntilDone: false)
        
        /* 1. 提交异步任务 */
        print("开始提交异步任务")
        DispatchQueue.global(qos: .default).async {
            Thread.sleep(forTimeInterval: 2)
            print("异步任务执行")
        }
        DispatchQueue.main.async {
            Thread.sleep(forTimeInterval: 2)

            print("异步任务执行2")

        }
        print("异步任务提交成功")
        print("\(Date())同步")
        DispatchQueue.global(qos: .default).sync {
            Thread.sleep(forTimeInterval: 2)
            print("同步任务执行")
        }
        print("\(Date())同步任务提交成功")
        print("定时任务")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            print("延迟执行")
        }
        print("定时任务开始")
//      线程队列组
        print("组调度")
//        组调度可以实现等待一组操作都完成后执行后续操作，典型的例子是大图片的下载，例如可以将大图片分成几块同时下载，等各部分都下载完后再后续将图片拼接起来，提高下载的效率。使用方法如下：
        
        let group = DispatchGroup.init()
        
        DispatchQueue.global().async(group: group, qos: .default, flags:[]) {
         print("组调度1")
        }
        DispatchQueue.global().async(group: group, qos: .default, flags:[]) {
         print("组调度2")
        }
        DispatchQueue.global().async(group: group, qos: .default, flags:[]) {
         print("组调度3")
        }
        group.notify(queue: DispatchQueue.main){
            print("组调度完成")
        }
        group.enter()
//      //线程锁
//        let lock = NSLock()
//        lock.lock()
//        do {
//            lock.unlock()
//        }
        
        // Do any additional setup after loading the view.
    }
    @objc func threadClick1(){
        print("run1")
    }
    @objc func threadClick2(){
        print("run2")
    }
    @objc func threadClick3(){
        print("run3")
    }
    @objc func threadClick4(){
        print("run4")
    }
    @objc func threadClick5(){
        print("run5")
    }
    @objc func threadClick6(){
        print("run6")
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
