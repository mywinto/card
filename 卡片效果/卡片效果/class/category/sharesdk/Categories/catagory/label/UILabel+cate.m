//
//  UILabel+cate.m
//  yihuo
//
//  Created by YHIOS on 2020/7/7.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import "UILabel+cate.h"

@implementation UILabel (cate)
+ (UILabel *)getLabelWithFontSize:(CGFloat)fontSize color:(NSInteger)color text:(NSString *)text{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = text;
    label.textColor = KUIColorFromRGB(color);
    return label;
}
+ (UILabel *)getAttrLabelWithFontSize:(CGFloat)fontSize color:(NSInteger)color text:(NSString *)text lineSpace:(CGFloat)lineSpace{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    
    
    NSAttributedString * str = [[NSAttributedString  alloc] initWithString:text attributes:
                                @{
                                      NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                      NSForegroundColorAttributeName:KUIColorFromRGB(color),
                                      NSParagraphStyleAttributeName:style
                                }];
    label.attributedText = str;
    return label;
    
}
@end
