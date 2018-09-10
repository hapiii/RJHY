//
//  HYStockBottomView.h
//  RJHY
//
//  Created by 王强 on 2018/8/2.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
typedef enum {
    bottomBuyIn = 0,
    bottomBuyOut = 1,
    bottomCollect = 2
}BottomBtnType;

typedef void (^clickTheBottomStockBtn)(BottomBtnType type);

@interface HYStockBottomView : HYBaseView

@property(nonatomic,copy)clickTheBottomStockBtn block;

@end
