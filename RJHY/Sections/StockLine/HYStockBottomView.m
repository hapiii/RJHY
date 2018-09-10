//
//  HYStockBottomView.m
//  RJHY
//
//  Created by 王强 on 2018/8/2.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYStockBottomView.h"

@implementation HYStockBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    if (self=[super init]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIButton *buyInbtn = [UIButton new];
    [self addSubview:buyInbtn];
    [buyInbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.35);
    }];
    [buyInbtn setBackgroundColor:kGreen_Color];
    [buyInbtn setTitle:@"买入" forState:UIControlStateNormal];
    
    UIButton *buyOutbtn = [UIButton new];
    [self addSubview:buyOutbtn];
    
    
    
    [buyOutbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyInbtn.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.35);
    }];
    [buyOutbtn setBackgroundColor:kRed_Color];
    [buyOutbtn setTitle:@"卖出" forState:UIControlStateNormal];
    
    UIButton *collectionBtn = [UIButton new];
    [self addSubview:collectionBtn];
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.2);
    }];
    [collectionBtn setImage:imgStr(@"star_common_light") forState:UIControlStateNormal];
    
}
@end
