//
//  TTTopChannelContianerView.h
//  TTNews
//
//  Created by wq on 16/4/29.
//  Copyright © 2016年 wq. All rights reserved.


#import <UIKit/UIKit.h>

@protocol TTTopChannelContianerViewDelegate <NSObject>

@optional


- (void)chooseChannelWithIndex:(NSInteger)index;



@end

@interface TTTopChannelContianerView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)selectChannelButtonWithIndex:(NSInteger)index;




@property (nonatomic, strong) NSArray *channelNameArray;

@property (nonatomic, weak) UIScrollView *scrollView;


@property (nonatomic, weak) id<TTTopChannelContianerViewDelegate> delegate;

@property (nonatomic,assign)CGFloat buttonWidth;

@end
