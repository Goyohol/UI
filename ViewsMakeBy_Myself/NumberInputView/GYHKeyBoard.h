//
//  GYHKeyBoard.h
//  inputView
//
//  Created by goyohol on 16/5/19.
//  Copyright © 2016年 goyohol. All rights reserved.
//

#import <UIKit/UIKit.h>

//制定协议 来显示内容
@protocol GYHKeyBoardDelegate <NSObject>
//显示 指定的文字
-(void)showText:(NSString *)test;
@end


@interface GYHKeyBoard : UIView

//需要 一个 代理
@property (nonatomic,weak) id<GYHKeyBoardDelegate> delegate;

@end
