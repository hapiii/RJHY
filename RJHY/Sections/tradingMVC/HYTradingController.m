//
//  HYTradingController.m
//  RJHY
//
//  Created by 王强 on 2018/7/23.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYTradingController.h"
#import "HYFigureFiveView.h"
#import "HYLineUtil.h"
#import "HYOrderUtil.h"
#import "HYPositionModel.h"
#import "HYPositionCell.h"
#import "HYUserInfoView.h"

@interface HYTradingController ()
@property(nonatomic,strong)HYFigureFiveView *figFiveView;
@property(nonatomic,strong)HYOrderUtil *util;
@property(nonatomic,strong)HYFigureFiveView *xibView;
@end

@implementation HYTradingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tradsTb];
    [self createHeadView];
    [self getDataWithIndex:0];
    [self getKLineView];
    
}
-(void)getKLineView{
    [[HYLineUtil Network] getDayStockLIneInfo:@"sh601789" WithType:dayKLine Success:^(NSArray *listData) {
//        [self.xibView.cell addDataWithKIineDataArr:listData];
//        self.dataArr = listData;
//        [self.tableView reloadData];
    }];
}
-(void)createHeadView{//
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 730)];
    
    HYUserInfoView *view = [[HYUserInfoView alloc] init];
    [bgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.offset(280);
    }];
     _xibView= [[[NSBundle mainBundle]loadNibNamed:@"HYFigureFiveView" owner:nil options:nil] lastObject];
    _xibView.backgroundColor = kWhite_Color;
    [bgView addSubview:_xibView];
    [_xibView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.offset(400);
    }];
    
    TTTopChannelContianerView * _ChannelView = [[TTTopChannelContianerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_xibView.frame), screenWidth, 45)];
    _ChannelView.buttonWidth = screenWidth/3;
    _ChannelView.channelNameArray = @[@"我的持仓",@"当日成交",@"当日委托"];
    _ChannelView.delegate = self;
    [bgView addSubview:_ChannelView];
    [_ChannelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xibView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.offset(45);
    }];
    self.tradsTb.tableHeaderView = bgView;
    
}


-(void)getDataWithIndex:(NSInteger )index{
    
    switch (index) {
        case 0:
        {
            //持仓
            [self.util getmobilesPosition:^(NSDictionary *listData) {
                NSLog(@"%@",listData);
                self.dataList = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [self.tradsTb reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
               
            } Failed:^(NSString *errStr) {
                [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                       toView:self.view
                                        title:errStr];
            }];
        }
            break;
        case 1:
        {
            //当日成交
            [self.util getJLJsonWithPage:1 RequestType:TodayClinchDeal Success:^(NSDictionary *listData) {
                
                self.dataList = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
                [self.tradsTb reloadData];
            } Failed:^(NSString *errStr) {
                [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                       toView:self.view
                                        title:errStr];
                
            }];
        }
            break;
        case 2:
        {
            //持仓
            //当日成交
            [self.util getJLJsonWithPage:1 RequestType:TodayEntrust Success:^(NSDictionary *listData) {
                
                self.dataList = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
                [self.tradsTb reloadData];
            } Failed:^(NSString *errStr) {
                [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                                       toView:self.view
                                        title:errStr];
                
            }];
        }
            break;
            
        default:
            break;
    }
   
}


-(void)chooseChannelWithIndex:(NSInteger)index{
    [self getDataWithIndex:index];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"positionId"];
    if (cell==nil) {
        cell = [[HYPositionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"positionId"];
        
    }
    cell.model = self.dataList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableView *)tradsTb{
    if (_tradsTb==nil) {
        _tradsTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tradsTb.delegate = self;
        _tradsTb.dataSource = self;
    }
    return _tradsTb;
}
-(HYOrderUtil *)util{
    if (_util==nil) {
        _util = [HYOrderUtil new];
    }
    return _util;
}
-(NSArray *)dataList{
    if (_dataList==nil) {
        _dataList = [NSArray new];
    }
    return _dataList;
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
