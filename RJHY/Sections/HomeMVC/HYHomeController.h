//
//  HYHomeController.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "HYHomeListTableView.h"
#import "HYTopScrollView.h"
#import "HYGoToTradCell.h"
#import "HYHomeTableContainer.h"
#import "HYUserInfoView.h"

@interface HYHomeController : HYBaseController



@property(nonatomic,strong)MyLinearLayout *lineContainer;
@property(nonatomic,strong)HYTopScrollView *topSc;
@property(nonatomic,strong)HYGoToTradCell *gtTradView;
@property(nonatomic,strong)UIScrollView *LineSc;
@property(nonatomic,strong)HYHomeTableContainer *tbContainer;
@property(nonatomic,strong)HYUserInfoView *userView;

@end
