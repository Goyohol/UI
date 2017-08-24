//
//  GYHYoukuSegmentView.h
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHYoukuSegmentView : UIView

@property (nonatomic,strong) NSArray * items;//(标题)数组

@property (nonatomic,assign) NSInteger selectedIndex;//选中下标

-(void)addTarget:(id)target withAction:(SEL)action;

@end
