//
//  WeakWebViewScriptMessageDelegate.m
//  易火
//
//  Created by YHIOS on 2020/5/29.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import "WeakWebViewScriptMessageDelegate.h"

@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}


//使用removeAllUserScripts移除，中间协议不会delloc
//要使用removeScriptMessageHandlerForName 移除就可以了

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
- (void)dealloc
{
}
@end

//// WKWebView 内存不释放的问题解决
//@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>
//
////WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
//@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;
//
//- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
//
//@end
//@implementation WeakWebViewScriptMessageDelegate
//
//- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
//    self = [super init];
//    if (self) {
//        _scriptDelegate = scriptDelegate;
//    }
//    return self;
//}
//
//
//
//
//#pragma mark - WKScriptMessageHandler
////遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
////通过接收JS传出消息的name进行捕捉的回调方法
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//
//    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
//        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
//    }
//}
//
//@end
