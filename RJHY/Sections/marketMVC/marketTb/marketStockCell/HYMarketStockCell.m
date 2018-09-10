//
//  HYMarketStockCell.m
//  RJHY
//
//  Created by 王强 on 2018/7/26.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYMarketStockCell.h"
@interface HYMarketStockCell()
@property(nonatomic,strong)HYMarketStockView *leftView;
@property(nonatomic,strong)HYMarketStockView *centerView;
@property(nonatomic,strong)HYMarketStockView *rightView;
@property(nonatomic,strong)UILabel *label;
@end
@implementation HYMarketStockCell

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
    
    _label = [UILabel new];
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView);
    }];
    _label.text = @"领涨模块";
    
    UIImageView *iv = [UIImageView new];
    [self.contentView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.label);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.equalTo(self.label.mas_height);
    }];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.image = imgStr(@"qy");
    
    for (int i = 0; i<3; i++) {
        HYMarketStockView *view = [[HYMarketStockView alloc] init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(screenWidth*i/3);
            make.top.equalTo(self.label.mas_bottom).offset(5);
            make.width.offset(screenWidth/3);
            make.bottom.equalTo(self.contentView);
        }];
        
        switch (i) {
            case 0:
                self.leftView = view;
                break;
            case 1:
                self.centerView = view;
                break;
            case 2:
                self.rightView = view;
                break;
                
            default:
                break;
        }
    }
}
-(void)setModelArrs:(NSArray<HYMarketStockModel *> *)modelArrs{
    _modelArrs = modelArrs;
    for (HYMarketStockModel *model in modelArrs) {
        switch ([modelArrs indexOfObject:model]) {
            case 0:{
                self.leftView.StockNameLab.text = model.category_cn;
                self.leftView.percentageLab.text = model.dropercent;
                self.leftView.messageLab.text = model.led_cname;
                self.leftView.increaseLab.text = model.increase;
                self.leftView.percentLab.text = model.percent;
            }
                break;
            case 1:{
                self.centerView.StockNameLab.text = model.category_cn;
                self.centerView.percentageLab.text = model.dropercent;
                self.centerView.messageLab.text = model.led_cname;
                self.centerView.increaseLab.text = model.increase;
                self.centerView.percentLab.text = model.percent;
            }
                break;
            case 2:{
                self.rightView.StockNameLab.text = model.category_cn;
                self.rightView.percentageLab.text = model.dropercent;
                self.rightView.messageLab.text = model.led_cname;
                self.rightView.increaseLab.text = model.increase;
                self.rightView.percentLab.text = model.percent;
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
}
-(void)setType:(NSInteger)type{
    switch (type) {
        case 0:
            self.label.text = @"领涨板块";
            break;
        case 1:
            self.label.text = @"行业板块";
            break;
        case 2:
            self.label.text = @"概念板块";
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
