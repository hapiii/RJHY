//
//  HYMarketController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYMarketController.h"

@interface HYMarketController ()

@end

@implementation HYMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar addSubview:self.navView];
    [self.view addSubview:self.marketTb];
    [self.marketTb loadData];
    [self.view addSubview:self.optionalTb];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark====lazy
-(HYNavBarView *)navView{
    if (_navView ==nil) {
        _navView = [[HYNavBarView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
        @weakify(self);
        _navView.NavClickBtn = ^(BtnType type) {
            @strongify(self);
            //self.view.backgroundColor = RandomColor;
            switch (type) {
                case 0:
                    
                    break;
                case 1:{
                    [self.optionalTb setHidden:YES];
                    [self.optionalTb setHidden:NO];
                }
                   break;
                case 2:{
                    [self.optionalTb setHidden:NO];
                    [self.optionalTb setHidden:YES];
                }
                   break;
                case 3:
                   
                    break;
                    
                default:
                    break;
            }
        };
        
    }
    return _navView;
}
-(HYoptionalTableView *)optionalTb{
    if (_optionalTb==nil) {
        _optionalTb = [[HYoptionalTableView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, screenWidth, screenHeight-getRectNavAndStatusHight-TabBarHeight) style:UITableViewStyleGrouped];
        [_optionalTb loadDataRise:YES];
        
    }
    return _optionalTb;
}
-(HYmarketTableView *)marketTb{
    if (_marketTb == nil) {
        _marketTb = [[HYmarketTableView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, screenWidth, screenHeight-getRectNavAndStatusHight-TabBarHeight) style:UITableViewStyleGrouped];
        
    }
    return _marketTb;
}
@end
