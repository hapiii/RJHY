//
//  HYFigureFiveView.m
//  RJHY
//
//  Created by 王强 on 2018/8/6.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYFigureFiveView.h"
#import "HYBaseCell.h"
#import "HYLineUtil.h"


@interface HYFigureFiveView()

@property (strong, nonatomic)HYBaseTableView *fiveTb;
@property (weak, nonatomic) IBOutlet YKTimeLineView *LineView;

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *moneyArr;
@property(nonatomic,strong)NSArray *countArr;
@property(nonatomic,strong)HYLineUtil *util;

@end

@implementation HYFigureFiveView

-(instancetype)init{
    
    if (self=[super init]) {
        
       
    }
    return self;
}
- (void)awakeFromNib{
        [super awakeFromNib];
    self.titleArr = @[@"涨停",@"卖五",@"卖四",@"卖三",@"卖二",@"卖一",@"最新",@"买一",@"买二",@"买三",@"买四",@"买五",@"跌停"];
    self.moneyArr = @[@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--"];
    self.countArr = @[@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--",@"--"];
        [self createUI];
        [self loadData];
    
}
-(void)udDateKLineViewWithArr:(NSArray *)arr{
    
}
-(void)loadData{
    
    _util = [HYLineUtil new];
    
    [_util getTimeDataInfoCode:@"601606" Success:^(HYNewStockDetailModel *model) {
        //NSLog(@"%@",model);
        self.moneyArr = @[model.sell5Money,model.sell4Money,model.sell3Money,model.sell2Money,model.sell1Money,[NSString stringWithFormat:@"%.2f",model.nowPrice],model.buy1Num,model.buy2Num,model.buy3Num,model.buy4Num,model.buy5Num];
        self.countArr = @[@"",model.sell5Num,model.sell4Num,model.sell3Num,model.sell2Num,model.sell1Num,@"",model.buy1Num,model.buy2Num,model.buy3Num,model.buy4Num,model.buy5Num];
        [self.fiveTb reloadData];
        
    }];
}

-(void)createUI{
    
    [self addSubview:self.fiveTb];
    [self.fiveTb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.5);
    }];
    
//    self.cell = [[StockChatCell alloc]init];
//    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    self.cell.selecIndex = 0;
//    self.cell.isHaveFigFive = NO;
//    [self.LineView addSubview:self.cell];
//    [self.cell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(self.LineView);
//    }];
   

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.moneyArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell==nil) {
        cell = [[HYBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        for (int i = 0; i<3; i++) {
            UILabel *label = [[UILabel alloc] init];
            [cell.contentView addSubview:label];
            label.font = [UIFont systemFontOfSize:14];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.width.equalTo(cell.contentView).multipliedBy(0.33);
make.left.equalTo(cell.contentView.mas_left).offset(i*screenWidth/6);
            }];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 0;
             label.tag = 20+i;
        }
    }
    for (int i=0; i<3; i++) {
        
        UILabel *label =[cell.contentView viewWithTag:20+i];
        switch (i) {
            case 0:
                label.text = self.titleArr[indexPath.row];
                break;
            case 1:
                label.text = self.moneyArr[indexPath.row];
                break;
            case 2:
                label.text = self.countArr[indexPath.row];
                break;
            default:
                break;
        }
    }
   
    return cell;
}
-(HYBaseTableView *)fiveTb{
    if (_fiveTb==nil) {
        _fiveTb = [[HYBaseTableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        _fiveTb.backgroundColor = kWhite_Color;
        _fiveTb.delegate =self;
        _fiveTb.dataSource = self;
        _fiveTb.separatorStyle = NO;
        _fiveTb.scrollEnabled = NO;
    }
    return _fiveTb;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



