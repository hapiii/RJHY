//
//  HYTopScrollView.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYTopScrollView.h"
#import <UIView+YYAdd.h>
#import "HYHomeUtil.h"
#import "HYLoginUtil.h"
@implementation HYTopScrollView{
    int _numCount;
    float _btnWeight;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _numCount = 2;
        _btnWeight = screenWidth/3;
        [self createUI];
        [self getTheData];
    }
    return self;
}
-(void)createUI{
    
   
    
    [self addSubview:self.scrollLabelView];
    [self addlittleHornImg];
    [self addSubview:self.topSc];
    [self addSubview:self.pageControl];
    [self addSubview:self.lineView];
    
    
}







-(void)getTheData{
    
    HYHomeUtil *util = [HYHomeUtil new];
    [util getScrollSix:^(NSDictionary *listData) {
         [self setLabelTextWithDate:listData];
    }];
    [util getRiseDropData:^(NSDictionary *listData) {
         [self setlineViewConfigWithData:listData];
    }];
    //登录
    [[HYLoginUtil new] LoginWithUserInfo:nil Success:^(NSDictionary *listData) {
        
    } Fail:^(id err) {
        
    }];
    
}

-(void)setLabelTextWithDate:(NSDictionary *)indexData{
    NSArray *arr = @[@"SH000001",@"SZ399006",@"SZ399001",@"SH000300",@"SZ399005",@"SZ399100"];
    NSArray *titleArr = @[@"上证指数",@"深圳指数",@"创业指数",@"沪深300",@"中小板指",@"新指数"];
    if (indexData.allKeys.count==arr.count) {
        for (int i=0;i<arr.count;i++) {
            HYTopScBtn *btn = [self.topSc viewWithTag:100+i];
            NSArray *detailArr = [indexData arrayForKey:arr[i]];
            btn.indexLabel.text = [titleArr objectAtIndexCheck:i];
            btn.countLabel.text = [detailArr objectAtIndexCheck:0];
            btn.pointLab.text = [detailArr objectAtIndexCheck:1];
            btn.percentageLab.text = [detailArr objectAtIndexCheck:2];
            
            float num = [[detailArr objectAtIndexCheck:2] floatValue];
            if (num>0) {
                btn.countLabel.textColor = kGreen_Color;
                btn.pointLab.textColor = kGreen_Color;
                btn.percentageLab.textColor = kGreen_Color;
               
            }else{
                btn.countLabel.textColor = kRed_Color;
                btn.pointLab.textColor = kRed_Color;
                btn.percentageLab.textColor = kRed_Color;
            }
        }
        
    }
}

-(void)setlineViewConfigWithData:(NSDictionary *)LineData{
    int rise = [[LineData numberForKey:@"stocks_total_count"] intValue];
    int drop = [[LineData numberForKey:@"surged_num_count"] intValue];
    self.lineView.roseLab.text = [NSString stringWithFormat:@"涨%i家",rise];
    self.lineView.dropLab.text = [NSString stringWithFormat:@"跌%i家",drop];
    self.lineView.LineSlider.value = (double)rise/(double)(rise+drop);
}
-(void)addlittleHornImg{
    UIImageView *iv = [UIImageView new];
    [self addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.width.height.offset(20);
        make.centerY.equalTo(self.scrollLabelView).offset(-10);
    }];
    iv.image = imgStr(@"index_notice_bg");
}
#pragma mark=====lazy
//50 150 20 30
-(TXScrollLabelView *)scrollLabelView{
    if (_scrollLabelView==nil) {
        NSString *scrollTitle = @"国臣在线App上线。\n \n 把握机遇，就在今天。\n \n  创享未来，拥抱成功。\n  \n 分享财富，共享人生。\n  \n 慧眼识金，财富共盈\n 服务从聆听开始。\n \n";
        _scrollLabelView = [TXScrollLabelView scrollWithTitle:scrollTitle type:TXScrollLabelViewTypeUpDown velocity:2 options:UIViewAnimationOptionTransitionFlipFromTop];
        _scrollLabelView.scrollLabelViewDelegate = self;
        _scrollLabelView.backgroundColor = [UIColor clearColor];
        _scrollLabelView.scrollTitleColor = [UIColor blackColor];
        _scrollLabelView.font = [UIFont systemFontOfSize:21];
        _scrollLabelView.frame = CGRectMake(20, 10, screenWidth-50, 30);
        [_scrollLabelView beginScrolling];
    }
    return _scrollLabelView;
}

-(UIScrollView *)topSc{
    if (_topSc==nil) {
        _topSc = [UIScrollView new];
        _topSc.frame = CGRectMake(0, 35, screenWidth, self.height-100);
        _topSc.contentSize = CGSizeMake(screenWidth*_numCount, 0);
        _topSc.contentOffset = CGPointMake(0, 0);
        _topSc.delegate = self;
        _topSc.pagingEnabled = YES;
        _topSc.showsHorizontalScrollIndicator = NO;
        for (int i=0;i<6;i++) {
            
            CGRect frame = CGRectMake(_btnWeight*i, 0, _btnWeight, _topSc.height);
            HYTopScBtn *btn = [[HYTopScBtn alloc] initWithFrame:frame];
            [_topSc addSubview:btn];
            btn.tag = 100+i;
            
        }
    }
    return _topSc;
}

-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth/2-50, self.topSc.bottom, 100, 20)];
        //点的数量；
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages =_numCount;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    }
    return _pageControl;
}
-(HYTopLineView *)lineView{
    if (_lineView==nil) {
        _lineView = [[HYTopLineView alloc] initWithFrame:CGRectMake(0, self.pageControl.bottom, screenWidth, 50)];
    }
    return _lineView;
}


#pragma mark =====View delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger i = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = i;
    [self getTheData];
}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@",text);
    
}
@end
