//
//  HYNavView.h
//  RJHY
//
//  Created by 王强 on 2018/8/1.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
typedef enum {
    TypeReturnBtn = 0,
    TypeChangeBtn = 1,
}navBtnType;


typedef void(^ClickNavIndex)(navBtnType type);
@interface HYNavView : HYBaseView

@property(nonatomic,copy)ClickNavIndex block;

@end
