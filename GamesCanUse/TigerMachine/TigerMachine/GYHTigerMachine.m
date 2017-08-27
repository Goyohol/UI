//
//  GYHTigerMachine.m
//  TigerMachine
//
//  Created by RainHeroic Kung on 2017/8/26.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GYHTigerMachine.h"


static BOOL isSliding = NO;
static const NSUInteger kMinTurn = 3;//圈数

@implementation GYHTigerMachine
{
@private
    // UI
    UIImageView *_backgroundImgV;
    UIImageView *_coverImgV;
    UIView *_contentView;
    UIEdgeInsets _contentInset;
    NSMutableArray *_unitScrollLayerArray;
    
    // 数据
    NSArray *_results;
    NSArray *_currentUnitResults;
    
    __weak id<GYHTigerMachineDataSource> _dataSource;
}


#pragma mark - 生命周期
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        _backgroundImgV = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImgV.contentMode = UIViewContentModeCenter;
        [self addSubview:_backgroundImgV];
        
        _contentView = [[UIView alloc] initWithFrame:frame];

        
        [self addSubview:_contentView];
        
        _coverImgV = [[UIImageView alloc] initWithFrame:frame];
        _coverImgV.contentMode = UIViewContentModeCenter;
        [self addSubview:_coverImgV];
        
        _unitScrollLayerArray = [NSMutableArray array];
        
        self.animationDuration = 0.14f;
        
        _contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}


#pragma mark - 属性
- (void)setBackgroundImg:(UIImage *)backgroundImg {
    _backgroundImgV.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImgV.image = backgroundImg;
}

-(void)setCoverImg:(UIImage *)coverImg {
    _coverImgV.contentMode = UIViewContentModeScaleAspectFill;
    _coverImgV.image = coverImg;
}

- (UIEdgeInsets)contentInset {
    return _contentInset;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    
    CGRect viewFrame = self.frame;
    
    _contentView.frame = CGRectMake(_contentInset.left, _contentInset.top, viewFrame.size.width - _contentInset.left - _contentInset.right, viewFrame.size.height - _contentInset.top - _contentInset.bottom);
}

- (NSArray *)results {
    return _results;
}

-(void)setResults:(NSArray *)results {
    if (!isSliding) {
        _results = results;
        
        if (!_currentUnitResults) {
            NSMutableArray *currentUnitResults = [NSMutableArray array];
            for (int i = 0; i < [results count]; i++) {
                [currentUnitResults addObject:[NSNumber numberWithUnsignedInteger:0]];
            }
            _currentUnitResults = [NSArray arrayWithArray:currentUnitResults];
        }
    }
}

- (id<GYHTigerMachineDataSource>)dataSource {
    return _dataSource;
}

- (void)setDataSource:(id<GYHTigerMachineDataSource>)dataSource {
    _dataSource = dataSource;
    
    [self reloadData];
}
- (void)reloadData {
    if (self.dataSource) {
        for (CALayer *containerLayer in _contentView.layer.sublayers) {
            [containerLayer removeFromSuperlayer];
        }
        _unitScrollLayerArray = [NSMutableArray array];
        
        NSUInteger numberOfUnit = [self.dataSource unitNumberInTigerMachine:self];
        CGFloat uintSpacing = 0;
        if ([self.dataSource respondsToSelector:@selector(unitSpacingInTigerMachine:)]) {
            uintSpacing = [self.dataSource unitSpacingInTigerMachine:self];
        }
        
        CGFloat uintWidth = _contentView.frame.size.width/numberOfUnit;
        if ([self.dataSource respondsToSelector:@selector(unitWidthInTigerMachine:)]) {
            uintWidth = [self.dataSource unitWidthInTigerMachine:self];
        }
        
        for (int i = 0; i < numberOfUnit; i++) { //添加4列的动画layer
            CALayer *uintContainerLayer = [[CALayer alloc] init];
            uintContainerLayer.frame = CGRectMake(i * (uintWidth + uintSpacing), 0, uintWidth, _contentView.frame.size.height);
            uintContainerLayer.masksToBounds = YES;
            
            CALayer *uintScrollLayer = [[CALayer alloc] init];
            uintScrollLayer.frame = CGRectMake(0, 0, uintWidth, _contentView.frame.size.height);

            [uintContainerLayer addSublayer:uintScrollLayer];
            
            [_contentView.layer addSublayer:uintContainerLayer];
            
            [_unitScrollLayerArray addObject:uintScrollLayer];//动画数组（4列）
        }
        
        CGFloat singleUnitHeight = _contentView.frame.size.height/3.f;//单个单位高度
        
        NSArray *unitIcons = [self.dataSource unitIconsInTigerMachine:self];
        NSUInteger iconCount = [unitIcons count];
        
        for (int i = 0; i < numberOfUnit; i++) {
            CALayer *uintScrollLayer = [_unitScrollLayerArray objectAtIndex:i];
            NSInteger scrollLayerTopIndex = - (i + kMinTurn + 3) * iconCount;
            
            for (int j = 0; j > scrollLayerTopIndex; j--) { //添加 各列的动画layer
//                NSLog(@"%lu",abs(j) % numberOfUnit);
                UIImage *iconImage = [unitIcons objectAtIndex:abs(j) % numberOfUnit];
                
                CALayer *iconImageLayer = [[CALayer alloc] init];
                
                NSInteger offsetYUnit = j + 1 + iconCount;
                iconImageLayer.frame = CGRectMake(0, offsetYUnit * singleUnitHeight, uintScrollLayer.frame.size.width, singleUnitHeight);
                
                iconImageLayer.contents = (id)iconImage.CGImage;
                iconImageLayer.contentsScale = iconImage.scale;
                iconImageLayer.contentsGravity = kCAGravityCenter;

                
                [uintScrollLayer addSublayer:iconImageLayer];
            }
        }
    }
    
}



- (void)clickSlide {
    NSLog(@"%@",_results);
    if (isSliding) {
        return;
    } else {
        isSliding = YES;
        
        if ([self.delegate respondsToSelector:@selector(unitMachineWillStartSlide:)]) {
            [self.delegate unitMachineWillStartSlide:self];
        }
        
        NSArray *unitIcons = [self.dataSource unitIconsInTigerMachine:self];
        NSUInteger unitIconsCount = [unitIcons count];
        
        __block NSMutableArray *completePositionArray = [NSMutableArray array];
        
        [CATransaction begin]; //开始动画
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [CATransaction setDisableActions:YES];
        [CATransaction setCompletionBlock:^{
            isSliding = NO;
            
            if ([self.delegate respondsToSelector:@selector(unitMachineDidEndSlide:)]) {
                [self.delegate unitMachineDidEndSlide:self];
            }
            
            for (int i = 0; i < [_unitScrollLayerArray count]; i++) { //每列滑动数组
                CALayer *unitScrollLayer = [_unitScrollLayerArray objectAtIndex:i];
                
                unitScrollLayer.position = CGPointMake(unitScrollLayer.position.x, ((NSNumber *)[completePositionArray objectAtIndex:i]).floatValue);
                
                NSMutableArray *toBeDeletedLayerArray = [NSMutableArray array];
                
                NSUInteger resultIndex = [[self.results objectAtIndex:i] unsignedIntegerValue];
                NSUInteger currentIndex = [[_currentUnitResults objectAtIndex:i] unsignedIntegerValue];
                
                for (int j = 0; j < unitIconsCount * (kMinTurn + i) + resultIndex - currentIndex; j++) {
                    CALayer *iconLayer = [unitScrollLayer.sublayers objectAtIndex:j];
                    [toBeDeletedLayerArray addObject:iconLayer];
                }
                
                for (CALayer *toBeDeletedLayer in toBeDeletedLayerArray) {
                    
                    CALayer *toBeAddedLayer = [CALayer layer];
                    toBeAddedLayer.frame = toBeDeletedLayer.frame;
                    toBeAddedLayer.contents = toBeDeletedLayer.contents;
                    toBeAddedLayer.contentsScale = toBeDeletedLayer.contentsScale;
                    toBeAddedLayer.contentsGravity = toBeDeletedLayer.contentsGravity;
                    
                    CGFloat shiftY = unitIconsCount * toBeAddedLayer.frame.size.height * (kMinTurn + i + 3);
                    toBeAddedLayer.position = CGPointMake(toBeAddedLayer.position.x, toBeAddedLayer.position.y - shiftY);
//                    NSLog(@"%f  %f",toBeAddedLayer.position.y,shiftY);
                    
                    [toBeDeletedLayer removeFromSuperlayer];
                    [unitScrollLayer addSublayer:toBeAddedLayer];
                }
                toBeDeletedLayerArray = [NSMutableArray array];
            }
            
            _currentUnitResults = self.results;
            completePositionArray = [NSMutableArray array];
        }];
        
        static NSString * const keyPath = @"position.y";
        
        for (int i = 0; i < [_unitScrollLayerArray count]; i++) {
            CALayer *unitScrollLayer = [_unitScrollLayerArray objectAtIndex:i];
            
            NSUInteger resultIndex = [[self.results objectAtIndex:i] unsignedIntegerValue];
            NSUInteger currentIndex = [[_currentUnitResults objectAtIndex:i] unsignedIntegerValue];
//            NSLog(@"%@ \n %@",self.results,_currentUnitResults);
            
            NSUInteger howManyUnit = (i + kMinTurn) * unitIconsCount + resultIndex - currentIndex;
//            NSLog(@"%ld",howManyUnit);
            CGFloat slideY = howManyUnit * (_contentView.frame.size.height/3.f);
            
            CABasicAnimation *slideAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
            slideAnimation.fillMode = kCAFillModeForwards;
            slideAnimation.duration = howManyUnit * self.animationDuration;
            slideAnimation.toValue = [NSNumber numberWithFloat:unitScrollLayer.position.y + slideY];
            slideAnimation.removedOnCompletion = NO;
            NSLog(@"%.1f  %.1f",unitScrollLayer.position.y,slideY);
//            NSLog(@"%@",slideAnimation.toValue);
            [unitScrollLayer addAnimation:slideAnimation forKey:@"slideAnimation"];
            
            [completePositionArray addObject:slideAnimation.toValue];
        }
        
        [CATransaction commit]; //提交 配置动画
    }
}
















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
