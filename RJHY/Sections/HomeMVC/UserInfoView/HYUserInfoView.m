//
//  HYUserInfoView.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYUserInfoView.h"
#import "HYInfoView.h"
#import "HYLoginUtil.h"

@implementation HYUserInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self createUI];
        //self.backgroundColor = [UITableVie];
        self.wrapContentHeight = YES;
        self.myHorzMargin = 0;
        [self loadData];
    }
    return self;
}
-(void)loadData{
    
    [[HYLoginUtil new] GetUserMoneySuccess:^(NSDictionary *listData) {
       
        NSArray *dataArr = @[[listData stringForKey:@"pureAmount"],
                             [listData stringForKey:@"marketValue"],
                             [listData stringForKey:@"availAmount"],
                             [listData stringForKey:@"wrongLine"],
                             [listData stringForKey:@"alertLine"],
                             [listData stringForKey:@"profitValue"],
                             [listData stringForKey:@"frozenMoney"],
                             @" ",
                             [listData stringForKey:@"sumAmountDd"]];
        for (int i = 0; i < dataArr.count; i++)
        {
            if (i==7) {
                
            }else{
                HYInfoView *view = [self.flowLayout viewWithTag:10+i];
                NSString *labStr = [dataArr objectAtIndexCheck:i];
                if (IS_EMPTY_STRING(labStr)) {
                     view.userMoneyLab.text = @"--";
                }
                view.userMoneyLab.text = [NSString stringWithFormat:@"%@",labStr];
            }
           
        }
        
    } Fail:^(id err) {
        
    }];
}
-(void)createUI{
    
    [self addSubview:self.flowLayout];
    NSArray *itemTitleArray = @[@"可用余额",@"股票市值",@"持仓盈亏",@"净资产",@"亏损警告线",@"亏损平仓线",@"冻结资产",@" ",@"总资产(人民币)"];
    
    [itemTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HYInfoView *view = [[HYInfoView alloc] init];
        view.userTitleLab.text = itemTitleArray[idx];
        view.backgroundColor = kWhite_Color;
        view.myWidth = (screenWidth-40)/3;
        view.myHeight = (screenWidth-40)/4;
        //label.heightSize.equalTo(label.widthSize);
        [self.flowLayout addSubview:view];
        view.tag = 10+idx;
       
    }];
    
}

-(MyFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout =  [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
        _flowLayout.wrapContentHeight = YES;
        _flowLayout.myWidth = screenWidth;
        _flowLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        _flowLayout.gravity = MyGravity_Horz_Fill;
        _flowLayout.subviewSpace = 10;
        _flowLayout.wrapContentHeight = YES;
        _flowLayout.gravity = MyGravity_Horz_Fill;
       
        
//        _flowLayout.myTop = kFitSize(25);
//        _flowLayout.myBottom = kFitSize(25);
//        _flowLayout.subviewVSpace = kFitSize(25);
//        _flowLayout.subviewHSpace = kFitSize(60);
//        _flowLayout.rightPadding = kFitSize(15);
//        _flowLayout.leftPadding = kFitSize(15);
//        _flowLayout.myHorzMargin = 0;

        
    }
    return _flowLayout;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
