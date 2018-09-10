//
//  HYNavBarView.h
//  RJHY
//
//  Created by 王强 on 2018/7/26.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
typedef  enum{
    navEditBtn=0,
    navChooseBtn=1,
    navMarketBtn=2,
    navSearchBtn=3,
}BtnType;

typedef void(^ClickTheNavBtn)(BtnType type);

@interface HYNavBarView : HYBaseView

@property(nonatomic,copy)ClickTheNavBtn NavClickBtn;
@end
