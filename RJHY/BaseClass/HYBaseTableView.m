//
//  HYBaseTableView.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseTableView.h"

@implementation HYBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self=[super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.showsVerticalScrollIndicator = NO;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    return self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
};
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
