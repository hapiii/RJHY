//
//  HYHomeStockCell.h
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseCell.h"
#import "HYHomeStockModel.h"

@interface HYHomeStockCell : HYBaseCell
@property(nonatomic,strong)UILabel *hNameLabel;
@property(nonatomic,strong)UILabel *hpCodeLabel;
@property(nonatomic,strong)UILabel *changeLabel;
@property(nonatomic,strong)UILabel *percentageLabel;
@property(nonatomic,strong)HYHomeStockModel *stockModel;
@property(nonatomic,strong)UIImageView *countImg;

@end
