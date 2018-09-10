//
//  HYmarketTableView.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYmarketTableView.h"
#import "HYHomeUtil.h"

@implementation HYmarketTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        
        
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
       
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        HYTopScrollView *view = [[HYTopScrollView alloc] initWithFrame:CGRectMake(0,0, screenWidth, 200)];
        view.scrollLabelView.hidden = YES;
        return view;
    }else{
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return 200;
    }
    return 20;
   
}

-(void)loadData{
   
    
    [[HYHomeUtil new] getMarketListType:riseModule Success:^(NSArray *listData) {
        self.arrRise = listData;
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        HYMarketStockCell *cell = [self cellForRowAtIndexPath:index];
        cell.modelArrs = listData;
       
        [self reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [[HYHomeUtil new] getMarketListType:IndustryModule Success:^(NSArray *listData) {
       self.arrIndustry = listData;
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        HYMarketStockCell *cell = [self cellForRowAtIndexPath:index];
        cell.modelArrs = listData;
        [self reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [[HYHomeUtil new] getMarketListType:conceptModule Success:^(NSArray *listData) {
        self.arrConcept = listData;
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:2];
        HYMarketStockCell *cell = [self cellForRowAtIndexPath:index];
        cell.modelArrs = listData;
        [self reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYMarketStockCell *cell = [[HYMarketStockCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    if (cell==nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    }
    cell.type = indexPath.section;
    
    if (self.arrRise.count>0&&indexPath.section==0) {
        cell.modelArrs = self.arrRise;
    }if (self.arrIndustry.count>00&&indexPath.section==1) {
        cell.modelArrs = self.arrIndustry;
    }if (self.arrConcept.count>00&&indexPath.section==2) {
        cell.modelArrs = self.arrConcept;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(NSArray *)arrRise{
    if (_arrRise==nil) {
        _arrRise = [NSArray new];
    }
    return _arrRise;
}
-(NSArray *)arrConcept{
    if (_arrConcept==nil) {
        _arrConcept = [NSArray new];
    }
    return _arrConcept;
}
-(NSArray *)arrIndustry{
    if (_arrIndustry==nil) {
        _arrIndustry = [NSArray new];
    }
    return _arrIndustry;
}



@end
