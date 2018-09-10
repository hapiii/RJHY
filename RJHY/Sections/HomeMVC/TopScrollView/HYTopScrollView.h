//
//  HYTopScrollView.h
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTopScBtn.h"
#import "HYTopLineView.h"
#import <TXScrollLabelView.h>

@interface HYTopScrollView : UIView<UIScrollViewDelegate,TXScrollLabelViewDelegate>

@property(nonatomic,strong)UIScrollView *topSc;
@property (nonatomic,strong)UIPageControl   *pageControl;
@property(nonatomic,strong)HYTopLineView *lineView;
@property(nonatomic,strong)TXScrollLabelView *scrollLabelView;
@end
