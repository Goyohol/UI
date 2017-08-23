//
//  GYHTextField.m
//  登录界面
//
//  Created by goyohol on 16/2/19.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import "GYHTextField.h"

@implementation GYHTextField

//重写  left视图的位置和大小 方法
-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGFloat margin = 5; //左边距
    CGFloat scale = 1.5f/2.0f; //左视图的宽高比
    CGFloat width = bounds.size.height * scale;//边长 ：正方形
    
    //确定x，y值
    CGFloat x = margin ;
    CGFloat y = (bounds.size.height - width)/2.0f;
    return CGRectMake(x, y, width, width);
}
////重新设置光标的位置和大小
//- (CGRect)editingRectForBounds:(CGRect)bounds
//{
//    CGFloat
//}

@end
