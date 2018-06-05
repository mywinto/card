//
//  ViewController.m
//  卡片效果
//
//  Created by CES on 2018/6/5.
//  Copyright © 2018年 CES. All rights reserved.
//

#import "ViewController.h"
#import "CardViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"进入卡片" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)click{
    CardViewController *card = [[CardViewController alloc] init];
    card.arr = @[@{@"img":@"1.jpg"},@{@"img":@"2.jpg"},@{@"img":@"3.jpg"}];
    [self presentViewController:card animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
