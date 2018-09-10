//
//  HYBaseView.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"

@implementation HYBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = kWhite_Color;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
