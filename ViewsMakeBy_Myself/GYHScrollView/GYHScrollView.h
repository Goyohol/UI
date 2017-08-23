//
//  GYHScrollView.h
//  3个iamgeView无限滚动
//
//  Created by goyohol on 16/3/2.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHScrollView : UIView//方便后面添加进 PageControl

-(void)imageNames:(NSArray *)imageNames;//让图片数组无限循环滚动

@end
