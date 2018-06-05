//
//  CardViewController.m
//  CardModeDemo
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 wenSir. All rights reserved.
//

#import "CardViewController.h"
#import "CustomSlideView.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define adsViewWidth  (ScreenWidth-70)
#define RatioValue  (APPScreenBoundsHeight-118)/450.0
#define APPScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
#define APPScreenBoundsWidth [UIScreen mainScreen].bounds.size.width

@interface CardViewController ()<SlideCardViewDelegate>
{
   
    CustomSlideView *_slide;
}
@property (nonatomic,assign) NSInteger select;
@end

@implementation CardViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
//    self.navigationController.navigationBarHidden = YES;
    
}
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColorStr toColor:(UIColor *)toHexColorStr{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromHexColorStr.CGColor,(__bridge id)toHexColorStr.CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _select = 2;
    self.view.backgroundColor = [UIColor colorWithRed:32/255.0 green:157/255.0 blue:254/255.0 alpha:1.0];
    [self.view.layer addSublayer:[self setGradualChangingColor:self.view fromColor:[UIColor colorWithRed:32/255.0 green:157/255.0 blue:254/255.0 alpha:1.0] toColor:[UIColor redColor]]];
    // Do any additional setup after loading the view from its nib.
    
//    self.title = @"CardDemo";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"nav_backW"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
   
    CGFloat height = (int)adsViewWidth*730/615;
    CGRect rect = {{lrintf((APPScreenBoundsWidth-adsViewWidth)/2.0),(ScreenHeight - height)/2},{lrintf(adsViewWidth) , adsViewWidth*730/615+58}};
    
    UIImageView *topImage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slide_top"]];
    topImage.frame = CGRectMake(100, CGRectGetMaxY(backBtn.frame)+5, ScreenWidth-200, 25);
    topImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:topImage];
    
    
    
    
    _slide = [[CustomSlideView alloc]initWithFrame:rect AndzMarginValue:9/(RatioValue) AndxMarginValue:11/(RatioValue) AndalphaValue:1 AndangleValue:2000];
    _slide.delegate = self;
    [_slide addCardDataWithArray:_arr];
//    _arr = item[@"data"][@"calls"];
    _slide.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_slide];
    
//    _slide.center = self.view.center;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"Tel"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(ScreenWidth*325/750, CGRectGetMaxY(_slide.frame) + (ScreenHeight-CGRectGetMaxY(_slide.frame)-ScreenWidth*100/750)/2-29, ScreenWidth*100/750, ScreenWidth*100/750);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(telClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self getData];
}
- (void)getData{

   
    
}
- (void)backClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)telClick:(UIButton *)sender{
//    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",@"4006783311"];
//
//    UIWebView *callWebview = [[UIWebView alloc]init];
//
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//
//    [self.view addSubview:callWebview];
    if (_arr.count > _select%_arr.count) {
        NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",[NSString stringWithFormat:@"%@",_arr[_arr.count - 1 - _select%_arr.count][@"phone"]]];
        
       
            
            /// 大于等于10.0 系统使用此的OpenURL 方法
            
            if (@available(iOS 10.0, *)) {
                [[ UIApplication sharedApplication ] openURL:[ NSURL URLWithString:str] options:@{} completionHandler:nil ];
            } else {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                // Fallback on earlier versions
            }
            
       
        
    }
   
}

#pragma mark- 代理
-(void)slideCardViewDidEndScrollIndex:(NSInteger)index
{
    _select = index;

//    NSLog(@"__end__%ld",index);
}

-(void)slideCardViewDidSlectIndex:(NSInteger)index
{
//    NSLog(@"__select__%ld",index);
}

-(void)slideCardViewDidScrollAllPage:(NSInteger)page AndIndex:(NSInteger)index
{
//    NSLog(@"__page__%ld__index__%ld",page,index);
    
    //判断是否为第一页
//    if(page == index){
//        if (self.comeBackFirstMessageButton.frame.origin.y<APPScreenBoundsHeight) {
//            [UIView animateWithDuration:0.8 animations:^{
//                self.comeBackFirstMessageButton.center = CGPointMake(self.comeBackFirstMessageButton.center.x, self.comeBackFirstMessageButton.center.y+self.comeBackFirstMessageButton.frame.size.height);
//            }];
//        }
//    }else{
//        if (self.comeBackFirstMessageButton.frame.origin.y>=APPScreenBoundsHeight) {
//            [UIView animateWithDuration:0.8 animations:^{
//                self.comeBackFirstMessageButton.center = CGPointMake(self.comeBackFirstMessageButton.center.x, self.comeBackFirstMessageButton.center.y-self.comeBackFirstMessageButton.frame.size.height);
//            }];
//        }
//    }
    
    //提醒已是最后一条消息,由透明慢慢显现
//    if (_curPage == _totalPage && slideImageView.scrollView.contentOffset.y<0) {
//        self.lastMessageLabel.alpha = -(slideImageView.scrollView.contentOffset.y/50.0);
//    }
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
