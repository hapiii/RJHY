//
//  HYStockLineController.m
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYStockLineController.h"
#import "StockChatCell.h"
#import "WYStockTopBarView.h"
#import "HYBaseCell.h"
#import "HYShrinkageCell.h"
@interface HYStockLineController ()
@property (nonatomic, strong)UITableView    *tableView;


@property (nonatomic ,strong)StockDataModel  *stock;//股票model
@property (nonatomic ,assign)NSInteger       selectIndex;//顶部topbar的点击索引(分时、五日...)
@property(nonatomic,assign)BOOL isOpen;
@end

@implementation HYStockLineController
//wq全部使用cell，点击head实现收缩，效果会很好多
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self getDataWithSelectIndex:0];
    [self getStockDetail];
    
}
#define marginTop ([[UIApplication sharedApplication] statusBarFrame].size.height>20?StatusHight:64)
-(void)configUI{
     self.view.backgroundColor = [UIColor whiteColor];
    self.isOpen = NO;
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.bottomBtns];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
        make.height.offset(64);
    }];
    [self.bottomBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.offset(NEWNavHeight);
    }];
    

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomBtns.mas_top);
    }];
    
    
    
}

#pragma mark====旋转View
-(void)perFormAdd{
  
     CGRect frame = [UIScreen mainScreen].applicationFrame;
    if (self.view.bounds.size.width==frame.size.width) {
        
        self.view.bounds = CGRectMake(0, 0, frame.size.height, frame.size.width);
        self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
       
        [self.navView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.offset(44);
        }];
        
       
       
        [self.tableView reloadData];
    }else{
       
        self.view.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.view.transform = CGAffineTransformMakeRotation(0);
        
        [self.navView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.right.equalTo(self.view);
            make.height.offset(64);
        }];
        [self.tableView reloadData];
       
    }
   
   

    
}



#pragma mark====Data
-(void)getStockDetail{
    
    [[HYLineUtil Network] getStockWholeDetialInfoCode:self.stockCode Success:^(NSString *str, NSArray *arr) {
        NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
        [mArr addObject:str];
        self.detailArr = [mArr copy];
        [self.tableView reloadData];
    }];
}

- (void)getDataWithSelectIndex:(NSInteger)selectIndex {
    
   
    
    if (selectIndex == 0) {
       
       
        [[HYLineUtil Network] getDayStockLIneInfo:self.stockCode WithType:dayKLine Success:^(NSArray *listData) {
            self.dataArr = listData;
            [self.tableView reloadData];
        }];
    }else{
        if (selectIndex == 1) {
            [[HYLineUtil Network] getStockLIneInfo:self.stockCode WithType:dayKLine Success:^(NSArray *listData) {
                self.dataArr = listData;
                [self.tableView reloadData];
            }];
            
        }else if (selectIndex == 2){
            [[HYLineUtil Network] getStockLIneInfo:self.stockCode WithType:weekKLine Success:^(NSArray *listData) {
                self.dataArr = listData;
                [self.tableView reloadData];
            }];
           
        }else{
            [[HYLineUtil Network] getStockLIneInfo:self.stockCode WithType:monthKline Success:^(NSArray *listData) {
               
                self.dataArr = listData;
                [self.tableView reloadData];
            }];
          
        }
    }
}

#pragma mark ------- tableView delegate  -----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _isOpen?2:1;
    }else if(section==1){
        return 0;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  section==0?0.01:WH_SCALE(50);
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 150;
        }else{
            return 100;
        }
    }else{
        return WH_SCALE(240);
    }
    
    
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return nil;
    }else if(section==1){
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width,50)];
        if ([[self.detailArr objectAtIndexCheck:31] floatValue]>=0) {
            [btn setBackgroundColor:[UIColor redColor]];
        }else{
            [btn setBackgroundColor:kGreen_Color];
        }
        @weakify(self);
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self);
            UIButton *senderBtn = (UIButton *)sender;
            self->_isOpen = !self->_isOpen;
            [self.tableView reloadData];
            
            senderBtn.tag = senderBtn.tag?0:1;
            if (senderBtn.tag) {
                [senderBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
                
            }else{
                [senderBtn setImage:[UIImage imageNamed:@"down2_small"] forState:UIControlStateNormal];
            }
        }];
        [btn setImage:[UIImage imageNamed:@"down2_small"] forState:UIControlStateNormal];
        
        
        return btn;
    }else{
        UIView *sectionView = [[UIView alloc]init];
        sectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
        sectionView.backgroundColor = Color_FromRGB(0xf5f5f5);
        
        
        WYStockTopBarView  *view = [[WYStockTopBarView alloc]initWithFrame:
                                    CGRectMake(0, WH_SCALE(15), sectionView.width, WH_SCALE(35)) SelecIndex: self.selectIndex
                                                                  titleArr:@[@"分时",@"日K",@"周K",@"月K"]];
        
        [view selectClick:^(NSInteger index) {
            
            
            self.selectIndex = index;
            [self getDataWithSelectIndex:self.selectIndex];
            
        }];
        
        [sectionView addSubview:view];
        
        return sectionView;
    }
   
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            HYBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section1"];
            if (cell==nil) {
                cell = [[HYBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"section1"];
            }
            HYStockDetailView *view = [[HYStockDetailView alloc] init];
            if (self.detailArr.count>0) {
                [view setViewTextWithArr:self.detailArr andTIme:self.detailArr.lastObject];
            }
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(cell.contentView);
            }];
            return cell;
        }else{
            HYShrinkageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shrinkCell"];
            if (cell==nil) {
                cell = [[HYShrinkageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shrinkCell"];
            }
            if (self.detailArr.count) {
                [cell setViewTextWithArr:self.detailArr];
            }
         return cell;
        }
    }else{
        static NSString       *identCell =  @"StockChatCell";
        
        StockChatCell *cell = [tableView dequeueReusableCellWithIdentifier:identCell];
        
        if (!cell) {
            cell = [[StockChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.selecIndex = self.selectIndex;
        cell.stock = self.stock;
        cell.isHaveFigFive = NO;
        if (self.dataArr.count!=0) {
            [cell addDataWithKIineDataArr:self.dataArr];
        }
        
        return cell;
        
    }
    
}



#pragma mark====delegate
-(void)HYStockDetailViewDidClickCloseButton:(HYStockDetailView *)itemView{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark====lazy
- (UITableView*)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    }
    _tableView.separatorStyle = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    
    return _tableView;
}



-(HYNavView *)navView{
    if (_navView==nil) {
        _navView = [[HYNavView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, NAVIGATION_BAR_HEIGHT)];
        @weakify(self);
        _navView.block = ^(navBtnType type) {
            @strongify(self);
            switch (type) {
                case TypeReturnBtn:
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                    break;
                case TypeChangeBtn:
                    [self perFormAdd];
                    break;
                default:
                    break;
            }
        };
    }
    return _navView;
}
-(HYStockBottomView *)bottomBtns{
    if (_bottomBtns==nil) {
        _bottomBtns = [[HYStockBottomView alloc] init];
    }
    return _bottomBtns;
}
-(NSArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr = [[NSArray alloc] init];
    }
    return _dataArr;
}


@end
