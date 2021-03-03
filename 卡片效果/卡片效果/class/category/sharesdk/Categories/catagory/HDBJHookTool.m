//
//  HDBJHookTool.m
//  yihuo
//
//  Created by YHIOS on 2020/6/22.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import "HDBJHookTool.h"

@implementation HDBJHookTool
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }

    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);

    class_replaceMethod(class,swizzledSelector,originalIMP,originalType);
    class_replaceMethod(class,originalSelector,swizzledIMP,swizzledType);
}
@end
