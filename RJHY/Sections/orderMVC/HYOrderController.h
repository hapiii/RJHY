//
//  HYOrderController.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "TTTopChannelContianerView.h"

#import "HYPositionController.h"
#import "HYCancelAtionsController.h"
#import "HYEntrustController.h"

@interface HYOrderController : HYBaseController<TTTopChannelContianerViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)TTTopChannelContianerView *navChannelView;
@property(nonatomic,strong)HYPositionController *positionC;
@property(nonatomic,strong)HYEntrustController *entrustC;
@property(nonatomic,strong)HYCancelAtionsController *cancelC;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@end
