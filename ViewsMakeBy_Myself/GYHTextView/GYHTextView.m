//
//  GYHTextView.m
//  teacherTrains
//
//  Created by RainHeroic Kung on 2017/1/15.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import "GYHTextView.h"

@implementation GYHTextView




-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 添加监听器，监听自己的文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加监听器，监听自己的文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
-(void)dealloc { //移除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 键盘文字的变化：文字一旦改变便调用setNeedsDisplay方法
-(void)textDidChange {
    // 会调用drawRect:方法，立即重新绘制占位文字
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    // 在textView的矩形框中绘制文字(placeholder)
    [self.placeholder drawInRect:CGRectMake(5, 8, self.frame.size.width, self.frame.size.height) withAttributes:attrs];
}


// 占位文字(placeholder)的setter方法
-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    // 文字一旦改变，立马重写绘制  （内部会调drawRect:方法）
    [self setNeedsDisplay];
}
// 字体属性setter方法
-(void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}









@end
