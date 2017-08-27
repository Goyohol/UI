//
//  GYHTigerMachine.h
//  TigerMachine
//
//  Created by RainHeroic Kung on 2017/8/26.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - ZCSlotMachine Delegate

@class GYHTigerMachine;

@protocol GYHTigerMachineDelegate <NSObject>

@optional
- (void)unitMachineWillStartSlide:(GYHTigerMachine *)tigerMachine;
- (void)unitMachineDidEndSlide:(GYHTigerMachine *)tigerMachine;

@end

@protocol GYHTigerMachineDataSource <NSObject>

@required
- (NSUInteger)unitNumberInTigerMachine:(GYHTigerMachine *)tigerMachine;
- (NSArray *)unitIconsInTigerMachine:(GYHTigerMachine *)tigerMachine;

@optional
- (CGFloat)unitWidthInTigerMachine:(GYHTigerMachine *)tigerMachine;
- (CGFloat)unitSpacingInTigerMachine:(GYHTigerMachine *)tigerMachine;

@end




@interface GYHTigerMachine : UIView

/* UI */
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic, strong) UIImage * backgroundImg;
@property (nonatomic, strong) UIImage * coverImg;

/* 数据 */
@property (nonatomic, strong) NSArray * results;

/* 动画 */
@property (nonatomic) CGFloat animationDuration;

/* 协议 */
@property (nonatomic, weak) id <GYHTigerMachineDelegate> delegate;
@property (nonatomic, weak) id <GYHTigerMachineDataSource> dataSource;


- (void)clickSlide;

@end
