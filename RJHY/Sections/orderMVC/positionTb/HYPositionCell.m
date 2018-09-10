//
//  HYPositionCell.m
//  RJHY
//
//  Created by 王强 on 2018/7/30.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYPositionCell.h"

@interface HYPositionCell()
@property(nonatomic,strong) UILabel *stockNameLab;
@property(nonatomic,strong) UILabel *marketvalueLab;
@property(nonatomic,strong) UILabel *presentpriceLab;
@property(nonatomic,strong) UILabel *stockPriceLab;
@property(nonatomic,strong) UILabel *quantityLab;
@property(nonatomic,strong) UILabel *frozenQuantityLab;
@property(nonatomic,strong) UILabel *profitpriceLab;
@property(nonatomic,strong) UILabel *profitblLab;

@end

@implementation HYPositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    _stockNameLab = [UILabel new];
    _marketvalueLab = [UILabel new];
    _presentpriceLab = [UILabel new];
    _stockPriceLab = [UILabel new];
    _quantityLab = [UILabel new];
    _frozenQuantityLab = [UILabel new];//0
    _profitpriceLab = [UILabel new];
    _profitblLab = [UILabel new];
    
    [self.contentView addSubview:self.stockNameLab];
    [self.contentView addSubview:self.marketvalueLab];
    [self.contentView addSubview:self.presentpriceLab];
    [self.contentView addSubview:self.stockPriceLab];
    [self.contentView addSubview:self.quantityLab];
    [self.contentView addSubview:self.frozenQuantityLab];
    [self.contentView addSubview:self.profitpriceLab];
    [self.contentView addSubview:self.profitblLab];
    
   
    
    
    [self.stockNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
    }];
    [self.marketvalueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stockNameLab);
        make.top.equalTo(self.stockNameLab.mas_bottom).mas_offset(10);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.presentpriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stockNameLab);
        make.left.equalTo(self.contentView).offset(screenWidth/4);
    }];
    self.presentpriceLab.textAlignment = NSTextAlignmentRight;
    [self.stockPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.marketvalueLab);
        make.left.equalTo(self.presentpriceLab);
    }];
    self.stockPriceLab.textAlignment = NSTextAlignmentRight;
    
    [self.quantityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stockNameLab);
        make.left.equalTo(self.contentView).offset(screenWidth/2);
    }];
    self.quantityLab.textAlignment = NSTextAlignmentRight;
    [self.frozenQuantityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.marketvalueLab);
        make.left.equalTo(self.quantityLab);
    }];
    self.frozenQuantityLab.textAlignment = NSTextAlignmentRight;
    
    [self.presentpriceLab makeLayout:^(MyMaker *make) {
        make.top.equalTo(self.stockNameLab);
    make.left.equalTo(self.contentView).offset(screenWidth*3/4);
    }];
    self.presentpriceLab.textAlignment = NSTextAlignmentLeft;
    
    [self.profitblLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stockNameLab);
        make.right.equalTo(self.contentView);
    }];
    
    UIButton *buyInBtn = [UIButton new];
    UIButton *saleOutBtn = [UIButton new];
    [self.contentView addSubview:buyInBtn];
    [self.contentView addSubview:saleOutBtn];
    
    [buyInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.marketvalueLab);
    make.left.equalTo(self.contentView).offset(screenWidth*3/4);
        make.width.offset(screenWidth/8-5);
        
    }];
    [buyInBtn setBackgroundColor:kGreen_Color];
    [buyInBtn setTitle:@"买入" forState:UIControlStateNormal];
    [buyInBtn setTitleColor:kWhite_Color forState:UIControlStateNormal];
    
    [saleOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.marketvalueLab);
        make.right.equalTo(self.contentView);
        make.width.offset(screenWidth/8-5);
    }];
    [saleOutBtn setBackgroundColor:kRed_Color];
    [saleOutBtn setTitle:@"卖出" forState:UIControlStateNormal];
    [saleOutBtn setTitleColor:kWhite_Color forState:UIControlStateNormal];
    
    self.profitblLab.textAlignment = NSTextAlignmentRight;
    
    self.stockNameLab.text = defaultStr
    self.marketvalueLab.text = defaultStr
    self.presentpriceLab.text = defaultStr
    self.stockPriceLab.text = defaultStr
    self.quantityLab.text = defaultStr
    self.frozenQuantityLab.text = defaultStr
    self.profitpriceLab.text = defaultStr
    self.profitblLab.text = defaultStr
    
}

- (void)setModel:(HYPositionModel *)model{
    _model = model;
    self.stockNameLab.text = model.stockName;
    self.marketvalueLab.text = model.marketvalue;
    self.presentpriceLab.text = model.presentprice;
    self.stockPriceLab.text = model.stockPrice;
    self.quantityLab.text = model.quantity;
    self.frozenQuantityLab.text = model.frozenQuantity;
    self.profitpriceLab.text = model.profitprice;
    self.profitblLab.text = model.profitbl;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
