//
//  CustomTableViewCell.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:14];
       
    }
    return self;
}

@end
