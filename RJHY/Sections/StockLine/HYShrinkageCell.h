//
//  HYShrinkageCell.h
//  RJHY
//
//  Created by 王强 on 2018/8/7.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseCell.h"

@interface HYShrinkageCell : HYBaseCell
@property(nonatomic,strong)MyFlowLayout *bottomView;
-(void)setViewTextWithArr:(NSArray *)arr;
@end
