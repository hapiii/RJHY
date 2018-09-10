//
//  HYFigureFiveView.h
//  RJHY
//
//  Created by 王强 on 2018/8/6.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYBaseView.h"
#import "HYBaseTableView.h"
#import "StockChatCell.h"

@interface HYFigureFiveView : HYBaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)StockChatCell *cell;
@end
