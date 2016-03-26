//
//  GYHManSegmentView.h
//  11264
//
//  Created by 千锋 on 16/3/26.
//  Copyright © 2016年 龚雨豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHManSegmentView : UIView

//items(需要的分段的标题数组)
@property (nonatomic,strong)NSArray * items;

//当前选中的下标
@property (nonatomic,assign)NSInteger seletedSegmentIndex;

//添加事件响应
-(void)addTarget:(id)target action:(SEL)action;

@end
