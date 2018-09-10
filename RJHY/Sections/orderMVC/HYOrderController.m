//
//  HYOrderController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYOrderController.h"

@interface HYOrderController (){
    NSArray *_ChannelArr;
}

@end

@implementation HYOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _ChannelArr = @[@"委托",@"撤单",@"持仓"];
    self.navigationController.title = nil;
    [self configUI];
    // Do any additional setup after loading the view.
}
-(void)configUI{
   [self.navigationController.navigationBar addSubview:self.navChannelView];
    [self addChildViewController:self.entrustC];
    [self addChildViewController:self.cancelC];
    [self addChildViewController:self.positionC];
    
    [self.view insertSubview:self.contentScrollView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    //[self chooseChannelWithIndex:0];
}


#pragma mark===delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        
        int i = scrollView.contentOffset.x/self.contentScrollView.frame.size.width;
        if (i==0) {
            HYBaseController *vc = self.childViewControllers[i];
               vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, self.contentScrollView.frame.size.height);
            [scrollView addSubview:vc.view];
        }else{
            HYBaseTBController *vc = self.childViewControllers[i];
            vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
            
            if (@available(iOS 11.0, *)) {
                
                vc.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                vc.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0, self.tabBarController.tabBar.frame.size.height, 0);//iPhoneX这里是88
                vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
            }else{
                vc.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0, self.tabBarController.tabBar.frame.size.height, 0);
                
            }
            
            [scrollView addSubview:vc.view];
        }
        
       
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        NSInteger index = scrollView.contentOffset.x/self.contentScrollView.frame.size.width;
        [self.navChannelView selectChannelButtonWithIndex:index];
    }
}
-(void)chooseChannelWithIndex:(NSInteger)index{
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.frame.size.width * index, 0) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark====lazy
-(UIScrollView *)contentScrollView{
    if (_contentScrollView ==nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.frame =  CGRectMake(0, 0, screenWidth, screenHeight);
        _contentScrollView.contentSize = CGSizeMake(screenWidth* 3, 0);
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
       
        
    }
    return _contentScrollView;
}
-(TTTopChannelContianerView *)navChannelView{
    
    if (_navChannelView==nil) {
        _navChannelView = [[TTTopChannelContianerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
        _navChannelView.buttonWidth = screenWidth/3;
        _navChannelView.channelNameArray = _ChannelArr;
        _navChannelView.delegate = self;
        
    }
    return _navChannelView;
}


-(HYCancelAtionsController *)cancelC{
    if (_cancelC==nil) {
        _cancelC = [[HYCancelAtionsController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _cancelC;
}
-(HYEntrustController *)entrustC{
    if (!_entrustC) {
        _entrustC = [[HYEntrustController alloc] init];
    }
    return _entrustC;
}
-(HYPositionController *)positionC{
    if (_positionC==nil) {
        _positionC = [[HYPositionController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _positionC;
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
