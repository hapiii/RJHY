//
//  HYHomeTableContainer.h
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
#import "HYHomeListTableView.h"
#import "TTTopChannelContianerView.h"

typedef void (^ClickTheCellGetStockCode)(NSString *stockCode);
@interface HYHomeTableContainer : HYBaseView<UIScrollViewDelegate>

@property(nonatomic,strong)HYHomeListTableView *riseTable;
@property(nonatomic,strong)HYHomeListTableView *dropTable;
@property(nonatomic,strong)TTTopChannelContianerView *topChannelView;
@property(nonatomic,strong)UIScrollView *ContentSc;
@property (nonatomic, strong) MyLinearLayout * linearView;
@property(nonatomic,copy)ClickTheCellGetStockCode codeBlock;
@end
