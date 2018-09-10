//
//  HYGoToTradCell.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYGoToTradCell.h"

@implementation HYGoToTradCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.bottom.right.equalTo(self).offset(-10);
    }];
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    UIImageView *iv = [UIImageView new];
    [bgView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(20);
        make.centerY.equalTo(bgView);
        make.width.height.equalTo(bgView.mas_height).offset(-20);
    }];
    iv.image = imgStr(@"rjhylogo");
    
    UILabel *gotoLab = [UILabel new];
    [bgView addSubview:gotoLab];
    [gotoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iv);
        make.left.equalTo(iv.mas_right).offset(20);
    }];
    gotoLab.text = @"前往交易\n 18配资交易入口";
}



@end
