//
//  HYBaseController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseController.h"
#import "HYHomeController.h"
#import "HYMyController.h"

@interface HYBaseController ()

@end

@implementation HYBaseController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//   
//    if ([self.class isKindOfClass:[HYHomeController class]]||[self.class isKindOfClass:[HYMyController class]]) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }else{
//         [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//  [self.navigationController setNavigationBarHidden:NO animated:YES];
//   
//}



- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //self.view.backgroundColor = kBackgroundGrayColor_Color;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    return NO;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
