//
//  UICollectionView+pop.m
//  yihuo
//
//  Created by YHIOS on 2020/7/3.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#import "UICollectionView+pop.h"

@implementation UICollectionView (pop)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}@end
