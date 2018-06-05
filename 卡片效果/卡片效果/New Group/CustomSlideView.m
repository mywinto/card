//
//  CustomSlideView.m
//  CardModeDemo
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 wenSir. All rights reserved.
//

#import "CustomSlideView.h"
#import "CardView.h"
#define bottom 58
@interface CustomSlideView()
{
    NSMutableArray *_cardViewArray;//存储底部的cardView
    NSMutableArray *_slideCardViewArray;//存储滑动的cardView
    
    UIView *_bottomView;//用于显示叠加效果的底部视图
    UIScrollView *_mainScrollView;//用于滑动的交互视图
    
    NSInteger _index;//序列号
}
@end

@implementation CustomSlideView

-(instancetype)initWithFrame:(CGRect)frame AndzMarginValue:(CGFloat)zMarginValue AndxMarginValue:(CGFloat)xMarginValue AndalphaValue:(CGFloat)alphaValue AndangleValue:(CGFloat)angleValue
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化
        self.cardDataArray = [[NSMutableArray alloc]init];
        _cardViewArray = [[NSMutableArray alloc]init];
        _slideCardViewArray = [[NSMutableArray alloc]init];
        self.zMarginValue = zMarginValue;
        self.xMarginValue = xMarginValue;
        self.alphaValue = alphaValue;
        self.angleValue = angleValue;
        
        //设置frame
        frame.origin = CGPointMake(0, 0);
        
        //初始化两个主要视图
        _bottomView = [[UIView alloc]initWithFrame:frame];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.layer.cornerRadius =20.0;
        
        _mainScrollView = [[UIScrollView alloc]initWithFrame:frame];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.autoresizingMask = YES;
        _mainScrollView.clipsToBounds = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.layer.cornerRadius = 20.0;
        
        [self addSubview:_bottomView];
        [self addSubview:_mainScrollView];
        
        //设置叠加视图的透视投影(这一步很重要)
        CATransform3D sublayerTransform = CATransform3DIdentity;//单位矩阵
        sublayerTransform.m34 = -0.002;
        [_bottomView.layer setSublayerTransform:sublayerTransform];
    }
    
    return self;
}
#pragma mark 开始创建cardView
-(void)addCardDataWithArray:(NSArray *)array
{
    
    //卡片数据
    [_cardDataArray removeAllObjects];
    for (int i = 0; i < 100; i ++) {
        [_cardDataArray addObjectsFromArray:array];
    }
    
    if (_cardDataArray.count) {
        _index = array.count-1;

        //加载叠加视图
        [self loadBottomView];
        //加载滚动视图
        [self loadSlideCardViewWithCount:_cardDataArray.count/2];
        [self scrollViewDidEndScrollingAnimation:_mainScrollView];
    }
}

#pragma mark 添加底部view
-(void)loadBottomView
{
//    if (_cardDataArray.count>10) {
//        return;
//    }
//
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    //设置4张图片展示效果 底部
    for(int i=0; i<(_cardDataArray.count<4?_cardDataArray.count:4); i++)
    {
        //设置CardView的坐标，z值和透明度
        //point.y设置y坐标从下往上排序
        CGPoint point = CGPointMake(0, -i*height/_xMarginValue);
        float zPosition = -i*height/_zMarginValue;
        
         #pragma mark  实例化CardView
        CardView *card = [[CardView alloc]initWithFrame:CGRectMake(point.x, point.y, width,height-bottom)];
        card.backgroundColor = [UIColor whiteColor];
        card.layer.masksToBounds = YES;
        card.layer.cornerRadius = 20.0;
        //添加数据
        [card loadCardViewWithDictionary:_cardDataArray[i]];
//        当修改zPosition属性值之后，layer会放大或者缩小
        if (i<3) {
            card.layer.zPosition = zPosition; // Z坐标
            card.alpha = 0.5;
        }else{
            card.layer.zPosition = zPosition; // Z坐标
            card.alpha = 0;
        }
        //添加到视图与数组中
        if(i == 0){
            card.hidden = YES;
        }
        
        [_cardViewArray insertObject:card atIndex:0];
        [_bottomView addSubview:card];
    }
    
}

#pragma mark- 加载最顶层的滚动视图 随手势变化滚动的cardview需改变数据
-(void)loadSlideCardViewWithCount:(NSInteger)count
{
    CGSize viewSize = _mainScrollView.frame.size;
    CGFloat width = viewSize.width; //图宽
    
//    if (_cardDataArray.count> 10) {
//        _mainScrollView.contentSize = CGSizeMake(width, viewSize.height*_cardDataArray.count);
//
//        //经过这个操作
//        [_mainScrollView setContentOffset:CGPointMake(0, _index* viewSize.height) animated:NO];
//
//        CardView*card = [_slideCardViewArray firstObject];
//        card.frame = CGRectMake(0, _index* viewSize.height, viewSize.width, viewSize.height-bottom);
//        return;
//    }
//
    //坐标
    CGPoint point = CGPointMake(0, (_cardDataArray.count-1)*viewSize.height);
    
#pragma mark  实例化CardView
    CardView *card = [[CardView alloc]initWithFrame:CGRectMake(point.x, point.y, viewSize.width, viewSize.height-bottom)];
//        card.backgroundColor = [UIColor yellowColor];
    card.layer.masksToBounds = YES;
    card.layer.cornerRadius = 20.0;//设置圆角
    
    
    [card loadCardViewWithDictionary:_cardDataArray[0]];
    
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelectCardViewAction)];
    [card addGestureRecognizer:tap];
    
    //添加到视图与数组中
    [_slideCardViewArray insertObject:card atIndex:0];
    [_mainScrollView addSubview:card];
    
    //设置滚动视图属性
    _mainScrollView.contentSize = _cardDataArray.count>1 ? CGSizeMake(width, viewSize.height*_cardDataArray.count):CGSizeMake(width, viewSize.height*_cardDataArray.count+1);
    
    _mainScrollView.contentOffset = CGPointMake(0, (_cardDataArray.count-1)/2* viewSize.height);
    if (_cardDataArray.count > 3) {
        //初始化错误
        CardView *vc = _cardViewArray.firstObject;
        vc.alpha = 0;
    }
}
//通过协议，告诉控制器选择的卡片
-(void)showSelectCardViewAction
{
    if([self.delegate respondsToSelector:@selector(slideCardViewDidSlectIndex:)])
    {
        [self.delegate slideCardViewDidSlectIndex:_index];
    }
    
//    //SQLog(@"%ld",_index);
}

#pragma mark- UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView //滚动时处理
{

    CGFloat offset_y = scrollView.contentOffset.y;//scrollView所在位置
    CGFloat height = scrollView.frame.size.height;//高度
    CGFloat currentIndex = offset_y/height;//当前标签
    
    //得到索引 往上滑加1 往下滑不变 当前scrollview显示的位置
    _index = (currentIndex > 0)?(int)currentIndex+1:(int)currentIndex;
    
    //currentIndex>(int)currentIndex?(int)currentIndex+1:(int)currentIndex;
//    _index取下一个位置跟随滑动
    if (_index>_cardDataArray.count-1) {
        _index = (int)_cardDataArray.count-1;
    }
    
    //调整滚动视图图片的角度
    CardView* scrollCardView = [_slideCardViewArray firstObject];
    
    //表示处于当前视图内
    if(scrollCardView.frame.origin.y<offset_y)
    {
        //1.超出scrollview contentsize的范围
        if((int)offset_y>(int)(_cardDataArray.count-1)*height){
            //滑出 contentsize
            scrollCardView.hidden = YES;
        }else{
//            contentsize之内
            scrollCardView.hidden = NO;
            scrollCardView.frame = CGRectMake(0, _index*height, scrollCardView.frame.size.width, scrollCardView.frame.size.height);
            [scrollCardView loadCardViewWithDictionary:_cardDataArray[_cardDataArray.count-1-_index]];
        }
    }
    else
    {
        scrollCardView.hidden = NO;

        scrollCardView.frame = CGRectMake(0, _index*height, scrollCardView.frame.size.width, scrollCardView.frame.size.height);
        [scrollCardView loadCardViewWithDictionary:_cardDataArray[_cardDataArray.count-1-_index]];
    }
    
    [self setBottomView:NO];
    
    //代理滚动时回调函数
    if([self.delegate respondsToSelector:@selector(slideCardViewDidScrollAllPage:AndIndex:)])
        [self.delegate slideCardViewDidScrollAllPage:_cardDataArray.count-1 AndIndex:_index];
}
- (void)setBottomView:(BOOL)isEnd{
    CGFloat offset_y = _mainScrollView.contentOffset.y;//scrollView所在位置
    CGFloat height = _mainScrollView.frame.size.height;//高度
    CGFloat width = _mainScrollView.frame.size.width;//视图宽度
    CGFloat currentIndex = offset_y/height;
    if (isEnd) {
        currentIndex = round(offset_y/height);
    }
    //底层图片赋值 4张
    NSInteger _select = _index > 3 ?(_index-3):0;
    
    for (NSInteger i=_select; i <= _index; i++) {
        //调整滚动视图图片的角度(当前跟随滚动的前三张图片位置)
        float currOrigin_y = i * height; //当前图片的y坐标
        
        //调整叠加视图
        CardView* moveCardView = [_cardViewArray objectAtIndex:i-_select];
        //添加数据
        [moveCardView loadCardViewWithDictionary:_cardDataArray[_cardDataArray.count-1-i]];
        
        float range_y = (currOrigin_y - offset_y)/(_xMarginValue) ;
        
        moveCardView.frame = CGRectMake(0, range_y, width, height-bottom);
        
        if(range_y >= 0){ // 如果超过当前滑动视图便隐藏
            moveCardView.hidden = YES;
        }
        else
        {
            moveCardView.hidden = NO;
        }
        
        //调整弹压视图的z值
        float range_z = -(offset_y-currOrigin_y)/_zMarginValue;
//        //SQLog(@"%f %f",range_z,range_y);
        moveCardView.layer.zPosition = range_z;
        
        //调整弹压视图的透明度
        float alpha = 1.f + (currOrigin_y-offset_y)/height/2;
        
        if(currentIndex-1 < i && i<=currentIndex){
            
            moveCardView.alpha = alpha;
            
        }else if (currentIndex-2 <= i && currentIndex-1 >= i ) {
            
            moveCardView.alpha = 0.5;
            
        }else if(currentIndex-2>i&&currentIndex-3<i){
            moveCardView.alpha = 0.5;
        }else{
            moveCardView.alpha = 0;
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    for(CardView* card in _slideCardViewArray)  //调整所有图片的z值
        card.layer.zPosition = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView //滚动结束处理
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _index = round(scrollView.contentOffset.y/scrollView.frame.size.height);
    //SQLog(@"%f %f %f",scrollView.contentOffset.y,scrollView.frame.size.height,scrollView.contentOffset.y/scrollView.frame.size.height);
    [self setBottomView:YES];
    if([self.delegate respondsToSelector:@selector(slideCardViewDidEndScrollIndex:)])
    {
        [self.delegate slideCardViewDidEndScrollIndex:_index];
    }
    if (_index && _index != _cardDataArray.count) {
        CardView* scrollCardView = [_slideCardViewArray firstObject];
        if(scrollCardView.frame.origin.y>scrollView.contentOffset.y+50){
            scrollCardView.hidden = YES;
        }
    }
    if (scrollView.contentOffset.y / scrollView.frame.size.height==0 || scrollView.contentOffset.y / (int)scrollView.frame.size.height==(_cardDataArray.count - 1)) {
        [self loadSlideCardViewWithCount:_cardDataArray.count/2];
        
    }
}

@end
