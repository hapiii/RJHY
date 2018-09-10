//
//  HYInfoView.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYInfoView.h"

@implementation HYInfoView
-(instancetype)init{
    if (self=[super init]) {
        self.wrapContentSize = YES;
         
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.userTitleLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.topPos.equalTo(self);
        label.rightPos.equalTo(self);
        label.leftPos.equalTo(self);
        label.myHeight =kFitSize(40);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        
        label;
    });
    self.userMoneyLab = ({
        UILabel *label = [UILabel new];
        [self addSubview:label];
        label.topPos.equalTo(self.userTitleLab.bottomPos);
        label.rightPos.equalTo(self);
        label.leftPos.equalTo(self);
        label.myHeight =kFitSize(40);
        
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
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
