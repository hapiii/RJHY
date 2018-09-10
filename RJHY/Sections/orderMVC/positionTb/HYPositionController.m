//
//  HYPositionController.m
//  RJHY
//
//  Created by 王强 on 2018/7/27.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYPositionController.h"
#import "HYPositionCell.h"
@interface HYPositionController ()

@end

@implementation HYPositionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     HYUserInfoView *view = [[HYUserInfoView alloc] initWithFrame:CGRectMake(0,0, screenWidth, 200)];
    self.tableView.tableHeaderView = view;
    //self.tableView.style = UITableViewStyleGrouped;
    [self.util getmobilesPosition:^(NSDictionary *listData) {
        NSLog(@"%@",listData);
        self.dataArr = [HYPositionModel mj_objectArrayWithKeyValuesArray:listData];
        [self.tableView reloadData];
    } Failed:^(NSString *errStr) {
        [MBProgressHUD showCustomView:[[UIImage imageNamed:@"item_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                               toView:self.view
                                title:errStr];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
-(HYOrderUtil *)util{
    if (_util==nil) {
        _util = [[HYOrderUtil alloc] init];
    }
    return _util;
}

@end
