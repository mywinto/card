//
//  UILabel+cate.h
//  yihuo
//
//  Created by YHIOS on 2020/7/7.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (cate)
+ (UILabel *)getLabelWithFontSize:(CGFloat)fontSize color:(NSInteger)color text:(NSString *)text;
+ (UILabel *)getAttrLabelWithFontSize:(CGFloat)fontSize color:(NSInteger)color text:(NSString *)text lineSpace:(CGFloat)lineSpace;


@end

NS_ASSUME_NONNULL_END
