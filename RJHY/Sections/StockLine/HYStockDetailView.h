//
//  HYStockDetailView.h
//  RJHY
//
//  Created by 王强 on 2018/7/31.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
@class HYStockDetailView;
@protocol HYStockDetailViewDelegate<NSObject>

- (void)DetailOpenOnBtnClick;

@end
typedef void(^HYStockDetailViewDidClickCloseButton)(void);
@interface HYStockDetailView : HYBaseView

@property(nonatomic,strong)MyFlowLayout *topView;

@property(nonatomic,weak)id<HYStockDetailViewDelegate> delegate;



@property(nonatomic,strong)UILabel *riseLabel;
@property(nonatomic,strong)UILabel *numberLab;
@property(nonatomic,strong)UILabel *percentageLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *openOnBtn;

-(void)setViewTextWithArr:(NSArray *)arr andTIme:(NSString *)time;

@end
