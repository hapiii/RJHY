//
//  TTTopChannelContianerView.m
//  TTNews
//
//  Created by wq on 16/4/29.
//  Copyright © 2016年 wq. All rights reserved.
//

#import "TTTopChannelContianerView.h"


#define kTitleLabelNorimalColor  [UIColor blackColor]
#define kTitleLabelSelectedColor   [UIColor colorWithHexString:@"#ff0036"]

@interface TTTopChannelContianerView()

@property (nonatomic, weak) UIButton *lastSelectedButton;
@property (nonatomic, weak) UIView *indicatorView;//小红线

@end

static CGFloat kTitleLabelNorimalFont = 15;//未选中字体大小
static CGFloat kTitleLabelSelectedFont = 17;//选中的字体大小
static CGFloat kSliderViewWidth = 20;


@implementation TTTopChannelContianerView

#pragma mark 初始化View
- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        [self initialization];
    }
     return self;
}


#pragma mark channelNameArray的setter方法，channelNameArray
- (void)setChannelNameArray:(NSArray *)channelNameArray {
    
    _channelNameArray = channelNameArray;

    
    self.scrollView.contentSize = CGSizeMake(self.buttonWidth * channelNameArray.count, 0);
    for (NSInteger i = 0; i < channelNameArray.count; i++) {
        UIButton *button = [self createChannelButton];
        
        
        button.frame = CGRectMake(i*self.buttonWidth, 0, self.buttonWidth, self.frame.size.height);
        [button setTitle:channelNameArray[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
    }
    [self clickChannelButton:self.scrollView.subviews[1]];
}

#pragma mark 初始化子控件
- (void)initialization{
    
    self.alpha = 0.9;
    self.backgroundColor = kRGBCOLOR(0xf0f0f0, 0x343434, 0xfafafa);
    UIScrollView *scrollView = [self createScrollView];
    self.scrollView = scrollView;
    [self addSubview:self.scrollView];
    
    //初始化scrollView右侧的显示阴影效果的imageView
    [self addSubview:[self createSliderView]];
    //初始化被选中channelButton的红线，也就是indicatorView
    UIView *indicatorView = [self createIndicatorView];
    self.indicatorView = indicatorView;
    [self.scrollView addSubview:self.indicatorView];

}

#pragma mark 创建容纳channelButton的ScrollView
- (UIScrollView *)createScrollView {

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    //scrollView.frame = self.frame;
    scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
    
}


- (UIView *)createIndicatorView {
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = kTitleLabelSelectedColor;
    [self addSubview:indicatorView];
    return indicatorView;
    
}


- (UIButton *)createChannelButton{
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
   [button.titleLabel setFont:[UIFont systemFontOfSize:kTitleLabelNorimalFont]];
  
    [button setTitleColor:kTitleLabelNorimalColor forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickChannelButton:) forControlEvents:UIControlEventTouchUpInside];
      
       [button layoutIfNeeded];
    return button;
}
#pragma mark 初始化scrollView右侧的显示阴影效果的imageView
- (UIView *)createSliderView {
    
    UIImageView *slideView = [[UIImageView alloc] init];
    slideView.frame = CGRectMake(self.frame.size.width-self.frame.size.width-kSliderViewWidth, 0, kSliderViewWidth, self.frame.size.height);
    slideView.alpha = 0.9;
    slideView.image = [UIImage imageNamed:@"slidetab_mask"];
    return slideView;
}




- (void)clickChannelButton:(UIButton *)sender{
   
    
    self.lastSelectedButton.titleLabel.font = [UIFont systemFontOfSize:kTitleLabelNorimalFont];
     [self.lastSelectedButton setTitleColor:kTitleLabelNorimalColor forState:UIControlStateNormal];
    
    self.lastSelectedButton.enabled = YES;
    self.lastSelectedButton = sender;
    self.lastSelectedButton.enabled = NO;
    
   /*偏移
    CGFloat newOffsetX = sender.center.x - [UIScreen mainScreen].bounds.size.width*0.5;
    
    if (newOffsetX < 0) {
        newOffsetX = 0;
    }

    if (newOffsetX > self.scrollView.contentSize.width - self.scrollView.frame.size.width) {
        newOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    }
     [self.scrollView setContentOffset:CGPointMake(newOffsetX,0)];
    */
    [UIView animateWithDuration:0.25 animations:^{
        [sender.titleLabel setFont:[UIFont systemFontOfSize:kTitleLabelSelectedFont]];
        [sender setTitleColor:kTitleLabelSelectedColor forState:UIControlStateNormal];
        [sender layoutIfNeeded];
        //indicatorView宽度会比titleLabel宽20，centerX与titleLabel相同  
        self.indicatorView.frame = CGRectMake(sender.frame.origin.x + sender.titleLabel.frame.origin.x - 10,self.frame.size.height - 2, sender.titleLabel.frame.size.width + 20, 2);
    }];
    
    NSInteger index = [self.scrollView.subviews indexOfObject:sender] - 1;
    if ([self.delegate respondsToSelector:@selector(chooseChannelWithIndex:)]) {
        [self.delegate chooseChannelWithIndex:index];
    }
}


#pragma mark 点击了某个频道按钮,用来给父图调用
- (void)selectChannelButtonWithIndex:(NSInteger)index {
    self.indicatorView.hidden = NO;
    [self clickChannelButton:self.scrollView.subviews[index+1]];
}




@end
