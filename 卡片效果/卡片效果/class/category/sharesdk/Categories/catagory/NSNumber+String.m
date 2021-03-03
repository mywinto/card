//
//  NSNumber+String.m
//  Runner
//
//  Created by YHIOS on 2020/5/13.
//

#import "NSNumber+String.h"

@implementation NSNumber (String)
- (NSString *)decimalNumberString{
    double conversionValue = self.floatValue;
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
- (NSString *)toString{
    return [NSString stringWithFormat:@"%@",self];
}
- (NSString *)toStringRound:(int)num{
    int sqr = 1;
    for(int i=0;i<num;i++){
        sqr = sqr * 10;
    }
    
    NSString * ff= [NSString stringWithFormat:@"%%.%df",num];
    return [NSString stringWithFormat:ff,round([self doubleValue]*sqr)/sqr];

}
- (NSString *)toStringRound:(int)num isShowEnd:(BOOL)showEnd{
    int sqr = 1;
    for(int i=0;i<num;i++){
        sqr = sqr * 10;
    }
    NSString * ff= [NSString stringWithFormat:@"%%.%df",num];
    NSString * result = [NSString stringWithFormat:ff,round([self doubleValue]*sqr)/sqr];
    
    if (showEnd == false) {
        NSInteger allLength = result.length;
        NSInteger dotpoint = [result rangeOfString:@"."].location;
        int zeroNum = 0;
        for (NSInteger i = allLength-1; i>dotpoint; i--) {
            NSString * p = [result substringWithRange:NSMakeRange(i, 1)];
            if ([p isEqualToString:@"0"]) {
                zeroNum = zeroNum + 1;
            }else{
                break;
            }
        }
        if (zeroNum  > 0) {
            if (zeroNum == num) {
                zeroNum = num + 1;
            }
            result = [result stringByReplacingCharactersInRange:NSMakeRange(allLength-zeroNum, zeroNum) withString:@""];
        }
    }
    return result;

}
/** 直接传入精度丢失有问题的Double类型*/
- (NSString *)toDecimalNumberString{
    double conversionValue = self.floatValue;
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


@end
