//
//  HYMarketStockView.m
//  RJHY
//
//  Created by 王强 on 2018/7/26.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYMarketStockView.h"

@implementation HYMarketStockView

-(instancetype)init{
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.StockNameLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.right.equalTo(self);
            
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"航空装备";
        label;
    });
    
    self.percentageLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.StockNameLab.mas_bottom).offset(5);
            make.left.right.equalTo(self);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"+6.63%";
        label;
    });
    
    self.messageLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.percentageLab.mas_bottom).offset(5);
            make.left.right.equalTo(self);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"航天信息";
        label;
    });
    
    self.increaseLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageLab.mas_bottom).offset(5);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(5);
        }];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"+2.64";
        label;
    });
    
    self.percentLab = ({
        
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.messageLab.mas_bottom).offset(5);
            make.right.equalTo(self).offset(-5);
            make.bottom.equalTo(self);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"+1.3%";
        label;
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
