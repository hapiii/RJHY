//
//  HYHomeController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYHomeController.h"
#import "HYStockLineController.h"

@interface HYHomeController ()

@end

@implementation HYHomeController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    //[self.view addSubview:self.HomeTb];
    
    // Do any additional setup after loading the view.
}
-(void)configUI{
    [self.view addSubview:self.LineSc];
    [self.LineSc addSubview:self.lineContainer];
    [self.lineContainer addSubview:self.topSc];
    [self.lineContainer addSubview:self.gtTradView];
    [self.lineContainer addSubview:self.userView];
    [self.lineContainer addSubview:self.tbContainer];
    @weakify(self);
    self.tbContainer.codeBlock = ^(NSString *stockCode) {
        HYStockLineController *vc = [[HYStockLineController alloc] init];
        @strongify(self);
        vc.stockCode = stockCode;
       
        [self presentViewController:vc animated:YES completion:nil];
    };
    
}
-(MyLinearLayout *)lineContainer{
    if (_lineContainer == nil) {
        _lineContainer = [[MyLinearLayout alloc] initWithFrame:CGRectMake(0, 20, screenWidth, screenHeight-getRectNavAndStatusHight) orientation:MyOrientation_Vert];
        _lineContainer.myHorzMargin = 0;
        _lineContainer.subviewSpace = 10;
        _lineContainer.wrapContentHeight = YES;
        _lineContainer.adjustScrollViewContentSizeMode = MyAdjustScrollViewContentSizeModeAuto;
        
    }
    return _lineContainer;
}

-(UIScrollView *)LineSc{
    
    if (_LineSc==nil) {
        _LineSc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, screenWidth, screenHeight-getRectNavAndStatusHight)];
        _LineSc.showsVerticalScrollIndicator = NO;
        _LineSc.showsHorizontalScrollIndicator = NO;
    }
    return _LineSc;
}

-(HYTopScrollView *)topSc{
    if (_topSc==nil) {
        _topSc = [[HYTopScrollView alloc] initWithFrame:CGRectMake(0,0, screenWidth, 200)];
        
    }
    return _topSc;
}
-(HYGoToTradCell *)gtTradView{
    if (_gtTradView==nil) {
        _gtTradView = [[HYGoToTradCell alloc] initWithFrame:CGRectMake(0,0, screenWidth, 100)];
    }
    return _gtTradView;
}
-(HYHomeTableContainer *)tbContainer{//200+100+200+50+80*10
    if (_tbContainer ==nil) {
        _tbContainer = [[HYHomeTableContainer alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 1020)];
        
    }
    return _tbContainer;
}
-(HYUserInfoView *)userView{
    if (_userView==nil) {
        _userView = [[HYUserInfoView alloc] initWithFrame:CGRectMake(0, 0, screenWidth-0, 200)];
        
    }
    return _userView;
}





@end
