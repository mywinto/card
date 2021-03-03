//
//  HDBJHookTool.h
//  yihuo
//
//  Created by YHIOS on 2020/6/22.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDBJHookTool : NSObject
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
