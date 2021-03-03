//
//  NSNumber+String.h
//  Runner
//
//  Created by YHIOS on 2020/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (String)
@property (nonatomic, strong,readonly) NSString *decimalNumberString;
- (NSString *)toString;
- (NSString *)toStringRound:(int)num;
- (NSString *)toStringRound:(int)num isShowEnd:(BOOL)showEnd;

- (NSString *)toDecimalNumberString;
@end

NS_ASSUME_NONNULL_END
