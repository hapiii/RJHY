//
//  HYShrinkageCell.m
//  RJHY
//
//  Created by 王强 on 2018/8/7.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYShrinkageCell.h"

@implementation HYShrinkageCell

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
    
 [self.contentView addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.right.bottom.equalTo(self.contentView);
        }];
    NSArray *itemTitleArray = @[@"开 da",@"高 22",@"高 21",@"量 3",@"高 21",@"量 3",@"高 21",@"量 3"];
    
    [itemTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *view = [[UILabel alloc] init];
        view.text = itemTitleArray[idx];
        view.myWidth = (screenWidth-40)/4;
        view.myHeight = 40;
        view.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        //label.heightSize.equalTo(label.widthSize);
        [self.bottomView addSubview:view];
        view.tag = 100+idx;
        
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = [UIColor whiteColor];
    }];
}
#define twoWordStr(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2];
#define ThreeWordStr(str1,str2,str3) [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];

-(void)setViewTextWithArr:(NSArray *)arr{
  
    
    
    NSString *tstr1 = twoWordStr(@"买盘",[arr objectAtIndexCheck:7])
    NSString *tstr2 = twoWordStr(@"卖盘",[arr objectAtIndexCheck:8])
    NSString *tstr3 = ThreeWordStr(@"振幅",[arr objectAtIndexCheck:43],@"%")
    float ti = [[arr objectAtIndexCheck:37] floatValue];
    float tj = ti/10000;
    NSString *tjStr = [NSString stringWithFormat:@"%.2f",tj];
    NSString *tstr4 = ThreeWordStr(@"成交额",tjStr,@"亿")
    
    float upF = [[arr objectAtIndexCheck:4] floatValue];
    float endupF = upF +upF*0.1;
    NSString *endupFStr = [NSString stringWithFormat:@"%.2f",endupF];
    
    float downF = [[arr objectAtIndexCheck:4] floatValue];
    float endDownF = downF -downF*0.1;
    NSString *enddownFStr = [NSString stringWithFormat:@"%.2f",endDownF];
    
    NSString *tstr5 = twoWordStr(@"涨停",endupFStr)
    NSString *tstr6 = twoWordStr(@"跌停",enddownFStr)
    NSString *tstr7 = twoWordStr(@"市净率",[arr objectAtIndexCheck:46])
    NSString *tstr8 = ThreeWordStr(@"流通",[arr objectAtIndexCheck:44],@"亿")
    
    NSArray *bottomArr = @[tstr1,tstr2,tstr3,tstr4,tstr5,tstr6,tstr7,tstr8];
    for (int i = 0;i<bottomArr.count ; i++) {
        UILabel *label = [self.contentView viewWithTag:100+i];
        label.text = [bottomArr objectAtIndexCheck:i];
    }
    if ([[arr objectAtIndexCheck:31] floatValue]>=0) {
       
        self.contentView.backgroundColor = [UIColor redColor];
    }else{
       
        self.contentView.backgroundColor = kGreen_Color;
    }
   
}
- (MyFlowLayout *)bottomView
{
    if (_bottomView == nil) {
        _bottomView =  [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:4];
        _bottomView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        _bottomView.wrapContentHeight = YES;
        _bottomView.myWidth = screenWidth;
        
        _bottomView.subviewSpace = 8;
        _bottomView.wrapContentHeight = YES;
        _bottomView.gravity = MyGravity_Horz_Fill;
    }
    return _bottomView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
