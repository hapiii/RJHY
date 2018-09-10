//
//  HYNavView.m
//  RJHY
//
//  Created by 王强 on 2018/8/1.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYNavView.h"

@implementation HYNavView

-(instancetype)init{
    if (self=[super init]) {
        [self configUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    UIButton *btn = [UIButton new];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.width.offset(40);
        make.bottom.equalTo(self).offset(-2);
    }];
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self->_block(TypeReturnBtn);
    }];
    [btn setImage:imgStr(@"back_black_light") forState:UIControlStateNormal];
    UILabel *label = [UILabel new];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-2);
    }];
    label.text = @"131";
    
    UIButton *changeBtn = [UIButton new];
    [self addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.width.height.offset(40);
        make.bottom.equalTo(self).offset(-2);
    }];
    
    [changeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        self->_block(TypeChangeBtn);
    }];
    [changeBtn setImage:imgStr(@"tradingview_change_landscape") forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
