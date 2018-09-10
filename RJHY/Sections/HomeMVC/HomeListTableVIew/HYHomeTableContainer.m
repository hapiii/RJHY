//
//  HYHomeTableContainer.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYHomeTableContainer.h"


@implementation HYHomeTableContainer{
    NSArray *_ChannelArr;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _ChannelArr = @[@"涨幅榜",@"跌幅榜"];
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
   
    [self addSubview:self.topChannelView];
    [self addSubview:self.ContentSc];
    
    //[self addSubview:view];
    
   
    
   
    [self setUpTableView];
    
}
-(void)setUpTableView{
    for (NSString *str in _ChannelArr) {
        if ([str isEqualToString:@"涨幅榜"]) {
            _riseTable = [[HYHomeListTableView alloc] initWithFrame:CGRectMake(screenWidth*[_ChannelArr indexOfObject:str], 0, screenWidth, 800)];
            @weakify(self);
            _riseTable.TBBlock = ^(NSString *stockCode) {
                @strongify(self);
                if (self.codeBlock) {
                    self.codeBlock(stockCode);
                }
            };
            [_riseTable loadDataRise:NO];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(screenWidth*[_ChannelArr indexOfObject:str], 50, screenWidth, 800)];
            view1.backgroundColor = RandomColor;
            [self.ContentSc addSubview:_riseTable];
        }else{
            _dropTable = [[HYHomeListTableView alloc] initWithFrame:CGRectMake(screenWidth*[_ChannelArr indexOfObject:str], 0, screenWidth, 800)];
            @weakify(self);
            
            _dropTable.TBBlock = ^(NSString *stockCode) {
                 @strongify(self);
                if (self.codeBlock) {
                    self.codeBlock(stockCode);
                }
            };
            [_dropTable loadDataRise:YES];
           
            [self.ContentSc addSubview:_dropTable];
        }
    }
}
#pragma mark====delegate
- (void)chooseChannelWithIndex:(NSInteger)index{
    [self.ContentSc setContentOffset:CGPointMake(self.ContentSc.frame.size.width * index, 0) animated:YES];
}
//10*80+50
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.ContentSc) {
        
        NSInteger index = scrollView.contentOffset.x/self.ContentSc.frame.size.width;
        [self.topChannelView selectChannelButtonWithIndex:index];
    }
}

#pragma mark====lazy
-(TTTopChannelContianerView *)topChannelView{
    if (_topChannelView==nil) {
        _topChannelView = [[TTTopChannelContianerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth/2, 50)];
        _topChannelView.buttonWidth = 60;
        _topChannelView.channelNameArray = _ChannelArr;
        _topChannelView.delegate = self;
        
    }
    return _topChannelView;
}
-(UIScrollView *)ContentSc{
    if (_ContentSc==nil) {
        _ContentSc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 800)];
        _ContentSc.contentSize = CGSizeMake(_ContentSc.frame.size.width* _ChannelArr.count, 800);
        _ContentSc.pagingEnabled = YES;
        _ContentSc.delegate = self;
       }
    return _ContentSc;
}

- (MyLinearLayout *)linearView
{
    if (_linearView == nil) {
        _linearView = [[MyLinearLayout alloc] init];
        _linearView.subviewVSpace = 15;
    }
    return _linearView;
}



@end
