//
//  GYHYoukuSegmentView.h
//  11264
//
//  Created by goyohol on 16/3/26.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHYoukuSegmentView : UIView

@property (nonatomic,strong) NSArray * items;//(标题)数组

@property (nonatomic,assign) NSInteger selectedIndex;//选中下标

-(void)addTarget:(id)target withAction:(SEL)action;

@end
