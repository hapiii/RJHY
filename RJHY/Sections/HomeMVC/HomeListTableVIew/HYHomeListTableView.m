//
//  HYHomeListTableView.m
//  RJHY
//
//  Created by 王强 on 2018/7/25.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYHomeListTableView.h"
#import "HYGoToTradCell.h"
#import "HYHomeStockCell.h"
#import "HYHomeUtil.h"
#import "HYLoginUtil.h"

@implementation HYHomeListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        
       
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
        
    }else{
        return 20;
        
    }
}

-(void)loadDataRise:(BOOL)isRise{
    
    [[HYHomeUtil new] getHomeListisRise:isRise Success:^(NSArray<HYHomeStockModel *> *listData) {
        self.dataArr = listData;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } Failed:^(NSString *errText) {
        [MBProgressHUD showOnlyTextToView:self title:@"加载列表失败"];
        HYHomeStockModel *model = [HYHomeStockModel new];
        model.name = @"一天天的没数据";
        self.dataArr = @[model];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
   
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count?self.dataArr.count:1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        HYHomeStockCell *cell = [[HYHomeStockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        if (cell==nil) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
           
            
        }
        cell.stockModel= self.dataArr[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"index_no_%li",(long)indexPath.row+1];
        cell.countImg.image = imgStr(str);
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYHomeStockModel *model = self.dataArr[indexPath.row];
   
if (self->_TBBlock) {
            self.TBBlock(model.symbol);
        }
  
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
