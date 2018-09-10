//
//  HYEntrustController.m
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYEntrustController.h"

@interface HYEntrustController ()

@end

@implementation HYEntrustController{
    NSArray *_channalArr;
    int _curretPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //self.tableView.alwaysBounceVertical=NO;
     self.automaticallyAdjustsScrollViewInsets = YES;//自动调整
   _channalArr = @[@"当日委托",@"当日成交",@"历史委托",@"历史成交"];
    [self.view addSubview:self.ChannelView];
    [self.view addSubview:self.tb];
    _curretPage = 1;
    self.currectType = TodayEntrust;
    [self getDataisreFresh:NO];
    [self creatrRefresh];
}
- (void)creatrRefresh{

    __unsafe_unretained UITableView *tableV = self.tb;

    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        //下拉的话，应该回到第一页
        self->_curretPage=1;
        [self getDataisreFresh:YES];


    }];
    //上拉加载；
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_curretPage++;
        [self getDataisreFresh:NO];
    }];


}

-(void)getDataisreFresh:(BOOL)isFresh{

    if (isFresh) {
        _curretPage = 1;
    }
    [self.util getJLJsonWithPage:_curretPage RequestType:self.currectType Success:^(NSDictionary *listData) {
        if (isFresh) {
            [self.dataList removeAllObjects];
        }
        NSArray *Arr = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
        [self.dataList addObjectsFromArray:Arr];
        
        
        [self.tb.mj_header endRefreshing];
        [self.tb.mj_footer endRefreshing];
        
        [self.tb reloadData];
    } Failed:^(NSString *errStr) {
        [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                               toView:self.view
                                title:errStr];
        [self.tb.mj_header endRefreshing];
        [self.tb.mj_footer endRefreshing];
    }];

    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count?self.dataList.count+1:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
           
            
                NSArray *arr = @[@"股票/市值",@"现价/成本",@"持仓/可用",@"盈亏/操作"];
                for (int i = 0; i<arr.count; i++) {

                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*i/arr.count, 0, screenWidth/arr.count, 50)];

                    label.text = [arr objectAtIndexCheck:i];
                    label.textAlignment = NSTextAlignmentCenter;
                    [cell.contentView addSubview:label];
                }
            
        }
        return cell;
    }
    else{
        HYPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"positionId"];
        if (cell==nil) {
            cell = [[HYPositionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"positionId"];

        }
        cell.model = self.dataList[indexPath.row-1];
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 45;
    }if (indexPath.row==1) {
        return 50;
    }
    return UITableViewAutomaticDimension;
}
-(HYOrderUtil *)util{
    if (_util==nil) {
        _util = [[HYOrderUtil alloc] init];
    }
    return _util;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(TTTopChannelContianerView *)ChannelView{
    if (_ChannelView==nil) {
        _ChannelView = [[TTTopChannelContianerView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight, screenWidth, 45)];
        _ChannelView.buttonWidth = screenWidth/4;
        _ChannelView.channelNameArray = _channalArr;
        _ChannelView.delegate = self;
        
    }
    return _ChannelView;
}
-(UITableView *)tb{
    
    if (_tb==nil) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ChannelView.frame), screenWidth, screenHeight-CGRectGetMaxY(self.ChannelView.frame)-TabBarHeight) style:UITableViewStylePlain];
        _tb.delegate = self;
        _tb.dataSource = self;
    }
    return _tb;
}

-(NSMutableArray *)dataList{
    if (_dataList==nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}
-(void)chooseChannelWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            self.currectType = TodayEntrust;
            break;
        case 1:
            self.currectType = TodayClinchDeal;
            break;
        case 2:
            self.currectType = HistoryEntrust;
            break;
        case 3:
            self.currectType = HistoryClinchDeal;
            break;
            
        default:
            break;
    }
    
    [self getDataisreFresh:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
 
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
