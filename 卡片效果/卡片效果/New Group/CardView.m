//
//  CardView.m
//  CardModeDemo
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 wenSir. All rights reserved.
//

#import "CardView.h"

@implementation CardView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!self.subviews.count) {
            CGFloat width = self.frame.size.width;
            UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tel_circle"]];
            image.frame = CGRectMake(width *275/615/2, width *120/615, width *340/615, width *340/615);
            [self addSubview:image];
            CGFloat width1 = image.frame.size.width * 251 /341;
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake((image.frame.size.width  - width1)/2, (image.frame.size.width  - width1)/2, width1, width1)];
//            image1.image = [UIImage imageNamed:@"header"];
            _headerView = image1;
            image1.layer.cornerRadius = width1/2;
            image1.layer.masksToBounds = YES;
            [image addSubview:image1];
            
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+30, width, 20)];
            _titleLabel = label;
            label.text = @"图片";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:17];
            [self addSubview:label];
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+15, width, 15)];
            _desLabel = label;
            label.text = @"天空";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            [self addSubview:label];
            self.backgroundColor = [UIColor whiteColor];
        }
        
    }
    return self;
}
-(void)loadCardViewWithDictionary:(id )dictionary
{
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
        self.headerView.image = [UIImage imageNamed:dictionary[@"img"]];
        
//        [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dictionary[@"img"]]] placeholderImage:[UIImage imageNamed:@"header1"]];
//        self.titleLabel.text = [NSString stringWithFormat:@"%@",dictionary[@"name"]];
    }
    
    
//    self.headerView.image = [UIImage imageNamed:(NSString *)dictionary];

//    self.backgroundColor = RGBCOLOR([[dictionary objectForKey:@"red"] floatValue], [[dictionary objectForKey:@"green"] floatValue], [[dictionary objectForKey:@"blue"] floatValue]);
}

@end
