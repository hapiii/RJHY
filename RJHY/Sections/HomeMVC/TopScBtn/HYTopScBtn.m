//
//  HYTopScBtn.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYTopScBtn.h"

@implementation HYTopScBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.backgroundColor = kWhite_Color;
    _indexLabel = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self);
        }];
        label.text = @"上证指数";
        label.font = kFitFont(21);
        label;
    });
    _countLabel = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.indexLabel.mas_bottom);
            make.centerX.equalTo(self);
        }];
        label.text = @"2829.16";
        label.font = kFitFont(23);
        label;
    });
    _pointLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countLabel.mas_bottom);
            make.left.equalTo(self).offset(20);
        }];
        label.text = @"-0.11";
        label.font = kFitFont(14);
        label;
    });
    _percentageLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countLabel.mas_bottom);
            make.right.equalTo(self).offset(-20);
        }];
        label.text = @"-0.11%";
        label.font = kFitFont(14);
        label;
    });
}
-(void)setLabelStrWithDataArr:(NSArray *)arr{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
