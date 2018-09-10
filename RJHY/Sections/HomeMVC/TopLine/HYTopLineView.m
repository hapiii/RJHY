//
//  HYTopLineView.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYTopLineView.h"

@implementation HYTopLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    _LineSlider = ({
        UISlider *slider = [UISlider new];
        [self addSubview:slider];
        [slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.width.equalTo(self);
            make.height.offset(5);
        }];
        slider.thumbTintColor = [UIColor grayColor];
        slider.minimumTrackTintColor = kRed_Color;
        slider.maximumTrackTintColor = kGreen_Color;
        
        
        [slider setThumbImage:imgStr(@"slider_btn") forState:UIControlStateHighlighted];
        
        [slider setThumbImage:imgStr(@"slider_btn") forState:UIControlStateNormal];

        [slider setContinuous:NO];
        [slider setUserInteractionEnabled:NO];
        slider.value=0.7;
        slider;
    });
    
    _roseLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LineSlider.mas_bottom).offset(2);
            make.left.equalTo(self);
        }];
        label.text = @"涨1773家";
        label.textColor = [UIColor redColor];
        label;
    });
    _dropLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.LineSlider.mas_bottom).offset(2);
            make.right.equalTo(self);
        }];
        label.text = @"跌1773家";
        label.textColor = kGreen_Color;
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
