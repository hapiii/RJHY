//
//  HYStockDetailView.m
//  RJHY
//
//  Created by 王强 on 2018/7/31.
//  Copyright © 2018年 王强. All rights reserved.
//

#import "HYStockDetailView.h"

@implementation HYStockDetailView
-(instancetype)init{
    if (self=[super init]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
    

    [self addSubview:self.topView];
   
    
    [self addSubview:self.riseLabel];
    [self addSubview:self.numberLab];
    [self addSubview:self.percentageLab];
    [self addSubview:self.timeLab];
   
    
    [self.riseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
    }];
     self.riseLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
    self.riseLabel.text = @"21";
    self.riseLabel.textColor = kWhite_Color;
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.riseLabel);
        make.left.equalTo(self.riseLabel.mas_right).offset(10);
    }];
    self.numberLab.text = @"+1.83";
    self.numberLab.textColor = kWhite_Color;
    [self.percentageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLab.mas_bottom).offset(10);
        make.left.equalTo(self.numberLab);
    }];
    self.percentageLab.text = @"+1.83";
    self.percentageLab.textColor = kWhite_Color;
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.percentageLab);
        make.right.equalTo(self);
    }];
    self.timeLab.text = @"2018-08";
    self.timeLab.textColor = kWhite_Color;
    
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(50);
        make.height.offset(100);
        
    }];

   
    
    
   
    
    
    NSArray *itemTitleArray = @[@"开 da",@"高 22",@"高 21",@"量 3",@"高 21",@"量 3",@"高 21",@"量 3"];
    
    [itemTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *view = [[UILabel alloc] init];
        view.text = itemTitleArray[idx];
        view.myWidth = (screenWidth-40)/4;
        view.myHeight = 40;
      
            view.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
         // Fallback on earlier versions
        
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = [UIColor whiteColor];
        //label.heightSize.equalTo(label.widthSize);
        [self.topView addSubview:view];
        view.tag = 10+idx;
        
        
    }];
    
   
    
//    [itemTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        UILabel *view = [[UILabel alloc] init];
//        view.text = itemTitleArray[idx];
//        view.myWidth = (screenWidth-40)/4;
//        view.myHeight = 40;
//         view.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
//        //label.heightSize.equalTo(label.widthSize);
//        [self.bottomView addSubview:view];
//        view.tag = 100+idx;
//        
//        view.textAlignment = NSTextAlignmentCenter;
//        view.textColor = [UIColor whiteColor];
//    }];
    
//    _openOnBtn = [UIButton new];
//    [self addSubview:_openOnBtn];
//    [_openOnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.equalTo(self);
//        make.height.offset(50);
//    }];
//
//
//   @weakify(self);
//    [self.openOnBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
//        @strongify(self);
//        [self.delegate DetailOpenOnBtnClick];
//
//        self.openOnBtn.tag = self.openOnBtn.tag?0:1;
//        if (self.openOnBtn.tag) {
//            [self.openOnBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
//
//        }else{
//            [self.openOnBtn setImage:[UIImage imageNamed:@"down2_small"] forState:UIControlStateNormal];
//        }
//    }];
//    [_openOnBtn setImage:[UIImage imageNamed:@"down2_small"] forState:UIControlStateNormal];
    
    
    
    
    
   
    
}
#define twoWordStr(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2];
#define ThreeWordStr(str1,str2,str3) [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
-(void)setViewTextWithArr:(NSArray *)arr andTIme:(NSString *)time{
    
    NSString *str1 = twoWordStr(@"开",[arr objectAtIndexCheck:5])
    //(float)Math.round((Float.parseFloat(stockInfoArr[36])/10000) *100)/100
    
    float i = [[arr objectAtIndexCheck:36] floatValue];
    float j = i/10000;
    NSString *jStr = [NSString stringWithFormat:@"%.2f",j];
    NSString *str2 = ThreeWordStr(@"高",jStr,@"万")
    NSString *str3 = twoWordStr(@"量",[arr objectAtIndexCheck:5])
    NSString *str4 = twoWordStr(@"市盈",[arr objectAtIndexCheck:39])
    NSString *str5 = twoWordStr(@"昨",[arr objectAtIndexCheck:4])
    NSString *str6 = twoWordStr(@"低",[arr objectAtIndexCheck:34])
    NSString *str7 = ThreeWordStr(@"换",[arr objectAtIndexCheck:38],@"%")
    NSString *str8 = ThreeWordStr(@"市值",[arr objectAtIndexCheck:45],@"亿")
    
    NSArray *topArr = @[str1,str2,str3,str4,str5,str6,str7,str8];
    for (int i = 0;i<topArr.count ; i++) {
        UILabel *label = [self viewWithTag:10+i];
        label.text = [topArr objectAtIndexCheck:i];
    }
    
    
    
//   NSString *tstr1 = twoWordStr(@"买盘",[arr objectAtIndexCheck:7])
//    NSString *tstr2 = twoWordStr(@"卖盘",[arr objectAtIndexCheck:8])
//    NSString *tstr3 = ThreeWordStr(@"振幅",[arr objectAtIndexCheck:43],@"%")
//    float ti = [[arr objectAtIndexCheck:37] floatValue];
//    float tj = ti/10000;
//    NSString *tjStr = [NSString stringWithFormat:@"%.2f",tj];
//    NSString *tstr4 = ThreeWordStr(@"成交额",tjStr,@"亿")
//
//    float upF = [[arr objectAtIndexCheck:4] floatValue];
//    float endupF = upF +upF*0.1;
//    NSString *endupFStr = [NSString stringWithFormat:@"%.2f",endupF];
//
//    float downF = [[arr objectAtIndexCheck:4] floatValue];
//    float endDownF = downF -downF*0.1;
//    NSString *enddownFStr = [NSString stringWithFormat:@"%.2f",endDownF];
//
//    NSString *tstr5 = twoWordStr(@"涨停",endupFStr)
//    NSString *tstr6 = twoWordStr(@"跌停",enddownFStr)
//    NSString *tstr7 = twoWordStr(@"市净率",[arr objectAtIndexCheck:46])
//    NSString *tstr8 = ThreeWordStr(@"流通",[arr objectAtIndexCheck:44],@"亿")
//
//    NSArray *bottomArr = @[tstr1,tstr2,tstr3,tstr4,tstr5,tstr6,tstr7,tstr8];
//    for (int i = 0;i<bottomArr.count ; i++) {
//        UILabel *label = [self viewWithTag:100+i];
//         label.text = [bottomArr objectAtIndexCheck:i];
//    }
    
    if ([[arr objectAtIndexCheck:31] floatValue]>=0) {
        self.numberLab.text = twoWordStr(@"+", [arr objectAtIndexCheck:31])
        self.percentageLab.text = ThreeWordStr(@"+", [arr objectAtIndexCheck:32],@"%")
        self.backgroundColor = [UIColor redColor];
    }else{
        self.numberLab.text =  [arr objectAtIndexCheck:31];
        self.percentageLab.text = twoWordStr([arr objectAtIndexCheck:32],@"%")
        self.backgroundColor = kGreen_Color;
    }
    self.riseLabel.text = [arr objectAtIndexCheck:4];
    self.timeLab.text = time;
}


- (MyFlowLayout *)topView
{
    if (_topView == nil) {
       
        _topView =  [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:4];
        _topView.wrapContentHeight = YES;
        _topView.myWidth = screenWidth;
        _topView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        _topView.gravity = MyGravity_Horz_Fill;
        _topView.subviewSpace = 10;
    }
    return _topView;
}
-(UILabel *)riseLabel{
    if (_riseLabel==nil) {
        _riseLabel = [UILabel new];
    }
    return _riseLabel;
}
-(UILabel *)numberLab{
    if (_numberLab==nil) {
        _numberLab = [UILabel new];
    }
    return _numberLab;
}
-(UILabel *)percentageLab{
    if (_percentageLab==nil) {
        _percentageLab = [UILabel new];
    }
    return _percentageLab;
}
-(UILabel *)timeLab{
    if (_timeLab==nil) {
        _timeLab = [UILabel new];
    }
    return _timeLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
