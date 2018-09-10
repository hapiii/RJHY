//
//  HYNavBarView.m
//  RJHY
//
//  Created by 王强 on 2018/7/26.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYNavBarView.h"

@implementation HYNavBarView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    UIButton *editBtn = [UIButton new];
    [self addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.offset(40);
    }];
    [editBtn setImage:imgStr(@"markets_edit") forState:UIControlStateNormal];
    
    [editBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.NavClickBtn) {
            self.NavClickBtn(navEditBtn);
        }
    }];
    
    
    UIButton *searchBtn = [UIButton new];
    [self addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.height.offset(40);
    }];

    [searchBtn setImage:imgStr(@"market_symbol_search_normal") forState:UIControlStateNormal];
    [searchBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (self.NavClickBtn) {
            self.NavClickBtn(navSearchBtn);
        }
    }];
    
    NSArray *array = [NSArray arrayWithObjects:@"自选",@"市场", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    [self addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.height.equalTo(searchBtn);
        make.width.offset(200);
    }];
    
    [segment addBlockForControlEvents:UIControlEventValueChanged block:^(id  _Nonnull sender) {
        UISegmentedControl *segment = sender;
        if (segment.selectedSegmentIndex==0) {
            if (self.NavClickBtn) {
                self.NavClickBtn(navChooseBtn);
            }
        }else{
            if (self.NavClickBtn) {
                self.NavClickBtn(navMarketBtn);
            }
        }
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
