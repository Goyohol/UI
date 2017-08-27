//
//  ViewController.m
//  TigerMachine
//
//  Created by RainHeroic Kung on 2017/8/26.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import "ViewController.h"


#import "GYHTigerMachine.h"
@interface ViewController () <GYHTigerMachineDataSource,GYHTigerMachineDelegate>

@end

@implementation ViewController
{
@private
    GYHTigerMachine *_tigerMachine;
    UIButton *_startButton;
    
    UIView *_resultContainerView;
    UIImageView *_unitOneImageView;
    UIImageView *_unitTwoImageView;
    UIImageView *_unitThreeImageView;
    UIImageView *_unitFourImageView;
    
    NSArray *_unitIcons;
}

#pragma mark - 生命周期
- (void)dealloc {
    [_startButton removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _unitIcons = @[
                   [UIImage imageNamed:@"cherry"],
                   [UIImage imageNamed:@"banana"],
                   [UIImage imageNamed:@"blueberry"],
                   [UIImage imageNamed:@"watermelon"]
                  ]; //图片数组
    
    
    /** 老虎机 */
    _tigerMachine = [[GYHTigerMachine alloc] initWithFrame:CGRectMake(0, 0, 250, 193)];
    _tigerMachine.center = CGPointMake(self.view.frame.size.width/2.f, self.view.frame.size.height/2.f);
    _tigerMachine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _tigerMachine.contentInset = UIEdgeInsetsMake(5, 8, 5, 8);
    _tigerMachine.backgroundImg = [UIImage imageNamed:@"machine"];
    _tigerMachine.coverImg = [UIImage imageNamed:@"machine"];
    
    _tigerMachine.delegate = self;
    _tigerMachine.dataSource = self;
    
    [self.view addSubview:_tigerMachine];
    
    
    /** 按钮 */
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImageNormal = [UIImage imageNamed:@"handleUp"];
    UIImage *btnImageHighLight = [UIImage imageNamed:@"handleDown"];
    _startButton.frame = CGRectMake(_tigerMachine.frame.origin.x+_tigerMachine.frame.size.width, _tigerMachine.frame.origin.y+_tigerMachine.frame.size.height*1/15.f, btnImageNormal.size.width, btnImageNormal.size.height);
//    _startButton.frame = CGRectMake(0, 0, btnImageNormal.size.width, btnImageNormal.size.height);
//    _startButton.center = CGPointMake(self.view.frame.size.width, self.view.frame.size.height-100.f);
    _startButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [_startButton setBackgroundImage:btnImageNormal forState:UIControlStateNormal];
    [_startButton setBackgroundImage:btnImageHighLight forState:UIControlStateHighlighted];
    [_startButton setBackgroundImage:btnImageNormal forState:UIControlStateDisabled];
    //_startButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    //[_startButton setTitle:@"开始" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_startButton];
    
    /** 提示箭头 */
    UIImageView * arrowImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"] ];
    arrowImgV.frame = CGRectMake(_tigerMachine.frame.origin.x+_tigerMachine.frame.size.width, _tigerMachine.frame.origin.y+_tigerMachine.frame.size.height + 20.f, arrowImgV.frame.size.width, arrowImgV.frame.size.height);
    [self.view addSubview:arrowImgV];
    /** 提示Label */
    UILabel * noticeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, arrowImgV.frame.origin.y+arrowImgV.frame.size.height + 20.f, self.view.frame.size.width-15.f, 50)];
    noticeLB.textAlignment = NSTextAlignmentRight;
    noticeLB.text = @"shake  switch";
    noticeLB.font = [UIFont fontWithName:@"Marker Felt" size:50.f];
    [self.view addSubview:noticeLB];
    
    
    
    /** 结果 */
    [self resultContainerShow];
}
-(void)resultContainerShow{
    
    _resultContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 185, 45)];
    _resultContainerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _resultContainerView.center = CGPointMake(self.view.frame.size.width / 2, 100);
    
    [self.view addSubview:_resultContainerView];
    
    _unitOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 45, 45)];
    _unitOneImageView.contentMode = UIViewContentModeCenter;
    
    _unitTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((45+1)+1, 0, 45, 45)];
    _unitTwoImageView.contentMode = UIViewContentModeCenter;
    
    _unitThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((45+1)*2+1, 0, 45, 45)];
    _unitThreeImageView.contentMode = UIViewContentModeCenter;
    
    _unitFourImageView = [[UIImageView alloc] initWithFrame:CGRectMake((45+1)*3+1, 0, 45, 45)];
    _unitFourImageView.contentMode = UIViewContentModeCenter;
    
    [_resultContainerView addSubview:_unitOneImageView];
    [_resultContainerView addSubview:_unitTwoImageView];
    [_resultContainerView addSubview:_unitThreeImageView];
    [_resultContainerView addSubview:_unitFourImageView];
}


#pragma mark - 私有方法
- (void)start {
    NSUInteger unitIconCount = [_unitIcons count];
    
//    NSUInteger unitOneIndex = abs(rand()%unitIconCount);
//    NSUInteger unitTwoIndex = abs(rand()%unitIconCount);
//    NSUInteger unitThreeIndex = abs(rand()%unitIconCount);
//    NSUInteger unitFourIndex = abs(rand()%unitIconCount);
    
    NSUInteger unitOneIndex = arc4random()%unitIconCount;
    NSUInteger unitTwoIndex = arc4random()%unitIconCount;
    NSUInteger unitThreeIndex = arc4random()%unitIconCount;
    NSUInteger unitFourIndex = arc4random()%unitIconCount;
    
    _unitOneImageView.image = [_unitIcons objectAtIndex:unitOneIndex];
    _unitTwoImageView.image = [_unitIcons objectAtIndex:unitTwoIndex];
    _unitThreeImageView.image = [_unitIcons objectAtIndex:unitThreeIndex];
    _unitFourImageView.image = [_unitIcons objectAtIndex:unitFourIndex];
    
    _tigerMachine.results = [NSArray arrayWithObjects:
                                [NSNumber numberWithInteger:unitOneIndex],
                                [NSNumber numberWithInteger:unitTwoIndex],
                                [NSNumber numberWithInteger:unitThreeIndex],
                                [NSNumber numberWithInteger:unitFourIndex],
                                nil];
    NSLog(@"%@",_tigerMachine.results);
    [_tigerMachine clickSlide];
}

#pragma mark - UIResponder
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    _startButton.highlighted = YES;
    [_startButton performSelector:@selector(setHighlighted:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.8];
    
    [self start];
}

#pragma mark - GYHTigerMachineDataSource
-(void)unitMachineWillStartSlide:(GYHTigerMachine *)tigerMachine {
    _startButton.enabled = NO;
    _resultContainerView.hidden = YES; //隐藏结果图
}
- (void)unitMachineDidEndSlide:(GYHTigerMachine *)tigerMachine {
    _startButton.enabled = YES;
    _resultContainerView.hidden = NO; //显示结果图
}


#pragma mark - GYHTigerMachineDelegate
-(NSArray *)unitIconsInTigerMachine:(GYHTigerMachine *)tigerMachine {
    return _unitIcons;
}
-(NSUInteger)unitNumberInTigerMachine:(GYHTigerMachine *)tigerMachine {
    return 4;
}
-(CGFloat)unitWidthInTigerMachine:(GYHTigerMachine *)tigerMachine {
    return 50.0f;
}
-(CGFloat)unitSpacingInTigerMachine:(GYHTigerMachine *)tigerMachine {
    return 10.0f;
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
