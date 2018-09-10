//
//  HYoptionalTableView.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYoptionalTableView.h"
#import "HYHomeUtil.h"

@implementation HYoptionalTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    NSArray *arr = @[@"名称",@"现价",@"涨幅"];
    for (int i = 0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*i/3, 0, screenWidth/3, 50)];
        label.text = [arr objectAtIndexCheck:i];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 50;
}

-(void)loadDataRise:(BOOL)isRise{
    
    [[HYHomeUtil new] getHomeListisRise:isRise Success:^(NSArray<HYHomeStockModel *> *listData) {
        self.dataArr = listData;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } Failed:^(NSString *errText) {
        [MBProgressHUD showOnlyTextToView:self title:@"加载列表失败"];
        self.dataArr = nil;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYHomeStockCell *cell = [[HYHomeStockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    if (cell==nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    }
    cell.stockModel= self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" ";
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{ return 0.01;
}

@end
