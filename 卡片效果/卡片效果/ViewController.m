//
//  ViewController.m
//  卡片效果
//
//  Created by CES on 2018/6/5.
//  Copyright © 2018年 CES. All rights reserved.
//

#import "ViewController.h"
#import "CardViewController.h"
#import "SlideVC.h"
#import "CityViewController.h"
#import "FoldCityViewController.h"
#import "AddressListView.h"
#import "SDViewController.h"
#import "AddressPickerView.h"
#import "DViewController.h"
#import "卡片效果-Swift.h"
#import "fontVC.h"
#import "TableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[@"进入card",@"仿百度滑动停止",@"地区选择列表样式",@"地区选择列表可折叠",@"地区选择picker",@"地区选择4",@"大小图轮播",@"自定义时间选择",@"flexlayout",@"字体",@"多线程",@"mvvm"];
    [self setView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)setView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"  forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CardViewController *card = [[CardViewController alloc] init];
        card.arr = @[@{@"img":@"1.jpg"},@{@"img":@"2.jpg"},@{@"img":@"3.jpg"}];
        [self.navigationController pushViewController:card animated:YES];
    }else  if (indexPath.row==1) {
        SlideVC *slide =[[SlideVC alloc] init];
        [self.navigationController pushViewController:slide animated:YES];
        
    }else  if (indexPath.row==2) {
        CityViewController *slide =[[CityViewController alloc]init];
        [self.navigationController pushViewController:slide animated:YES];
        
    }else  if (indexPath.row==3) {
        FoldCityViewController *slide =[[FoldCityViewController alloc] init];
        [self.navigationController pushViewController:slide animated:YES];
        
    }else  if (indexPath.row==4) {
        AddressListView *  listView = [[AddressListView alloc]init];
        listView.addressBlock = ^(NSString *addressStr, NSString *adcodeStr) {
            NSLog(@"string = %@\nstrID = %@",addressStr,adcodeStr);
            //               [weakSelf.addressListButton setTitle:addressStr forState:UIControlStateNormal];
        };
        
        [listView show];

    }else  if (indexPath.row==5) {
        
        AddressPickerView  *pickerView = [[AddressPickerView alloc]init];
        pickerView.addressBlock = ^(NSString *addressStr, NSString *adcodeStr) {
            NSLog(@"string = %@\nstrID = %@",addressStr,adcodeStr);
            //               [weakSelf.addressPickerButton setTitle:addressStr forState:UIControlStateNormal];
        };
        [pickerView show];
    }else  if (indexPath.row==6) {
        
        SDViewController  *pickerView = [[SDViewController alloc]init];
        [self.navigationController pushViewController:pickerView animated:YES];
    }else  if (indexPath.row==7) {
        
        DViewController  *pickerView = [[DViewController alloc]init];
        [self.navigationController pushViewController:pickerView animated:YES];
    }else  if (indexPath.row==8) {
        FlexTestVC  *testVC = [[FlexTestVC alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
    }else if (indexPath.row==9) {
        fontVC  *testVC = [[fontVC alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
    }else if (indexPath.row==10) {
        threadViewController  *testVC = [[threadViewController alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
    }else if (indexPath.row==11) {
        TableViewController  *testVC = [[TableViewController alloc]init];
        [self.navigationController pushViewController:testVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
