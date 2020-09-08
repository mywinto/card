//
//  SlideVC.m
//  卡片效果
//
//  Created by CES on 2018/6/5.
//  Copyright © 2018年 CES. All rights reserved.
//

#import "SlideVC.h"
#import "UIView_extra.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Status_H 100
#define Tabbar_H 100
@interface SlideVC()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIImageView *image1;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) CGFloat detailPY;
@property (nonatomic,strong) UIView *detailView;//
@end

@implementation SlideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBottomView];
    // Do any additional setup after loading the view.
}

#pragma mark 添加滑动窗口
- (void)setBottomView{
    UIView *detail = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-Tabbar_H-ScreenWidth*92/750, ScreenWidth, ScreenHeight-Status_H-Tabbar_H)];
    //    detail.backgroundColor = BaseColor12;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*92/750)];
    label.backgroundColor = [UIColor purpleColor];
    label.text = @"头";
    label.textAlignment = NSTextAlignmentCenter;
    [detail addSubview:label];
    _image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull_clicked"]];
    _image1.frame = CGRectMake(0, label.height/2-5, label.width, 10);
    _image1.contentMode = UIViewContentModeScaleAspectFit;
    [label addSubview:_image1];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), ScreenWidth, detail.height-label.height)];
    backView.backgroundColor = [UIColor greenColor];
    [detail addSubview:backView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), ScreenWidth, detail.height-label.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [detail addSubview:_tableView];
    
    _detailView = detail;
    _detailPY = _detailView.y;
    //    _detailView.hidden = YES;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detailViewSwipe:)];
    pan.delegate = self;
    [_detailView addGestureRecognizer:pan];
    [self.view addSubview:detail];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self setScrollViewPostion:scrollView detailView:self.detailView topH:kScreenHeight/2];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setFinishDetialViewPosition:self.detailView topH:kScreenHeight/2];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self setScrollViewPostion:scrollView detailView:self.detailView topH:kScreenHeight/2];
//    if (_tableView.contentOffset.y <= 0) {
//        self.detailView.y = self.detailView.y - _tableView.contentOffset.y;
//
//        _tableView.contentOffset  = CGPointZero;
//    }
    
}
/// #pragma mark

-(void)setScrollViewPostion:(UIScrollView *)scrollView detailView:(UIView *)detailView  topH:(CGFloat)topH{
    if (scrollView.contentOffset.y <= 0) {
        if (detailView.y - scrollView.contentOffset.y < topH){
            
        }else{
            detailView.y = detailView.y - scrollView.contentOffset.y;
            scrollView.contentOffset  = CGPointMake(0, 0);
        }
        
    }else if (detailView.y > topH) {
        if (detailView.y - scrollView.contentOffset.y < topH){
            
        }else{
            detailView.y = detailView.y - scrollView.contentOffset.y;
            scrollView.contentOffset  = CGPointMake(0, 0);
        }
        
    }else if(detailView.y != topH){
        detailView.y = topH;
    }
}

/// <#Description#>
/// - Parameters:
///   - detailView: 需要移动的view
///   - topH:需要移动的view frame y
///   - pointView: pan相对postion view
-(void)setPanViewPostion:(UIView *)detailView topH:(CGFloat)topH pointView:(UIView *)pointView sender:(UIPanGestureRecognizer *)sender{
    CGPoint transP = [sender translationInView:pointView];
    CGFloat y = transP.y + topH;
    if( y < topH) {
        y = topH;
    }
    detailView.y = y;
    
}
-(void)setFinishDetialViewPosition:(UIView *)detailView topH:(CGFloat)topH {
    CGFloat p = 0;
    if (detailView.y > topH + (kScreenHeight - topH)/3){
        p = kScreenHeight;
    }else{
        p = topH;
        if (detailView.y < topH) {
            detailView.y = p;
            return;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        detailView.y = p;
    } completion:^(BOOL finished) {
        if(p != topH){
            ////            finishBlock()
        }
    }];
    //    UIView.animate(withDuration: 0.3, animations: {
    //        detailView.y = p
    //    }) { (finish) in
    //        if(p != topH){
    ////            finishBlock()
    //        }
    //    }
}

#pragma mark 滑动事件
- (void)detailViewSwipe:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self.view];
    if(_detailView.y <= Status_H && point.y < 0)
    {
        _detailView.y = Status_H;
        
    }else{
        if (_detailView.y > Status_H ) {
            _tableView.contentOffset = CGPointZero;
            //        DebugLog(@"%@",_tableView.panGestureRecognizer);
            
        }
        if ( _detailView.y == Status_H && _tableView.contentOffset.y > 0 && _tableView.panGestureRecognizer.state != UIGestureRecognizerStatePossible) {
            [sender setTranslation:CGPointMake(0, 0) inView:self.view];
            
            return;
        }
        _detailView.y = _detailView.y + point.y;
        
    }
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [self openDetialView:(_detailView.y - _detailPY)];
    }
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
}
#pragma mark 打开详情
- (void)openDetialView:(CGFloat)distance{
    CGFloat centreP = _detailView.height/2;
    CGFloat bottom = _detailView.height - ScreenWidth*92/750 + Status_H;
    CGFloat p = bottom;
    
    if (_detailPY == Status_H) {
        if (distance<=0) {
            
            p=Status_H;
        }else{
            p = centreP;
        }
        
    }else if(_detailPY == centreP){
        if (distance<0) {
            p = Status_H;
        }else{
            p = bottom;
        }
    }else{
        if (distance<0) {
            p = centreP;
        }else{
            p = bottom;
        }
    }
    if(_detailView.y < Status_H)
    {
        p =Status_H;
    }
    if (p != Status_H) {
        _tableView.contentOffset = CGPointZero;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self->_detailView.y = p;
        self->_detailPY = p;
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"  forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1.0];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
