//
//  HYCancelAtionsController.m
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYCancelAtionsController.h"

@interface HYCancelAtionsController ()

@end

@implementation HYCancelAtionsController{
    int _curretPage;
}

- (void)viewDidLoad {
    _curretPage = 1;
    
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self getDataisreFresh:NO];
    [self creatrRefresh];
}
- (void)creatrRefresh{
   
    __unsafe_unretained UITableView *tableV = self.tableView;
    
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        //下拉的话，应该回到第一页
        self->_curretPage=1;
        [self getDataisreFresh:YES];
        
        
    }];
    
    //这个方法可以自动调整透明度，吊吊的
    //self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //上拉加载；
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_curretPage++;
        [self getDataisreFresh:NO];
    }];
    
    
}

-(void)getDataisreFresh:(BOOL)isFresh{
    
    
    [self.util getmobileWtjlJsonWithPage:_curretPage isToday:YES Success:^(NSDictionary *listData) {
        if (isFresh) {
            [self.dataArr removeAllObjects];
        }
        NSArray *Arr = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
        [self.dataArr addObjectsFromArray:Arr];
        
      
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
    } Failed:^(NSString *errStr) {
        [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                               toView:self.view
                                title:errStr];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}
#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArr.count) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
        NSArray *arr = @[@"股票/市值",@"现价/成本",@"持仓/可用",@"盈亏/操作"];
        for (int i = 0; i<arr.count; i++) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*i/arr.count, 0, screenWidth/arr.count, 50)];
            
            label.text = [arr objectAtIndexCheck:i];
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        return view;
    }
    return nil;
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArr.count) {
        return 50;
    }
    return 0.01;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYPositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"positionId"];
    if (cell==nil) {
        cell = [[HYPositionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"positionId"];
        
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
