//
//  GYHsegmentView.h
//  4 GYHSegmentView
//
//  Created by 千锋 on 16/2/22.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHsegmentView : UIView

//items(需要的分段的标题数组)
@property (nonatomic,strong)NSArray * items;

//当前选中的下标
@property (nonatomic,assign)NSInteger seletedSegmentIndex;

//添加事件响应
-(void)addTarget:(id)target action:(SEL)action;

@end
