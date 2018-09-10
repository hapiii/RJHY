//
//  HYHomeStockCell.m
//  RJHY
//
//  Created by 王强 on 2018/7/24.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYHomeStockCell.h"

@implementation HYHomeStockCell

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
    
        self.countImg = ({
            
            UIImageView *iv = [UIImageView new];
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self.contentView).offset(10);
                make.width.height.offset(15);
            }];
            iv;
        });
       
        
    
    
    self.hNameLabel = ({
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.countImg.mas_right).offset(20);
        }];
        label.text = @"黄庭B";
        label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        label;
    });
    
    self.hpCodeLabel = ({
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hNameLabel.mas_bottom).offset(5);
            make.left.equalTo(self.hNameLabel).offset(10);
        }];
        label.text = @"sz200056";
        label.textColor = [UIColor lightGrayColor];
        //label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        label;
    });
    self.changeLabel = ({
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hNameLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView).offset(-10);
        }];
        label.text = @"-3.41";
        label.textColor = kGreen_Color;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        label;
    });
    
    self.percentageLabel = ({
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
        }];
        label.text = @"-100.0%";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = kGreen_Color;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        label;
    });
   
    
}
-(void)setStockModel:(HYHomeStockModel *)stockModel{
    _stockModel = stockModel;
    self.hNameLabel.text = stockModel.name;
    self.hpCodeLabel.text = stockModel.symbol;
    self.changeLabel.text = stockModel.low;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
