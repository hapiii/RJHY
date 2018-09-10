//
//  HYTabBarController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYHomeController.h"
#import "HYTradingController.h"
#import "HYMarketController.h"
#import "HYOrderController.h"
#import "HYMyController.h"
#import "HYStockLineController.h"
@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setup];
    
    // Do any additional setup after loading the view.
}

- (void)setup {
    
//
//    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
//    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    
   
    
    HYHomeController *home= [HYHomeController new];
    HYMarketController *market= [HYMarketController new];
    HYTradingController *trad= [HYTradingController new];
    HYOrderController *order= [HYOrderController new];
    HYMyController *my= [HYMyController new];
    
    
    self.viewControllers = @[home,market,trad,order,my];
    
    
    [self addChildViewController:home imageName:@"tb_icon_home_light" selectedImageName:@"tb_icon_home" title:@"首页"];
    [self addChildViewController:market imageName:@"tb_icon_hq_light" selectedImageName:@"tb_icon_hq" title:@"行情"];
    [self addChildViewController:trad imageName:@"tb_icon_trade_light" selectedImageName:@"tb_icon_trade" title:@"交易"];
    [self addChildViewController:order imageName:@"tb_icon_hold_light" selectedImageName:@"tb_icon_hold" title:@"订单"];
    [self addChildViewController:my imageName:@"tb_icon_profile_light" selectedImageName:@"tb_icon_profile" title:@"我的"];
    
    // this make tabBaController call
   
    
    
    
}


- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)normalImg selectedImageName:(NSString *)selectImg title:(NSString *)title {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
  
    childController.title = title;
     childController.navigationItem.title = title;
    
    [self addChildViewController:nav];
}





//-(BOOL)shouldAutorotate
//{
//
//    for (UINavigationController *vc in self.viewControllers) {
//        UINavigationController *nav = vc;
//        if ([nav.topViewController isKindOfClass:[HYStockLineController class]]) {
//            return YES;
//        }
//    }
//    return NO;
//}

//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
//- (NSUInteger)supportedInterfaceOrientations
//#else
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//#endif
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//
//    return UIInterfaceOrientationPortrait;
//}


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

@end
