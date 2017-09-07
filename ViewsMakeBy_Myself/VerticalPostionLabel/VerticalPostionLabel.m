//
//  VerticalPostionLabel.m
//  teacherTrains
//
//  Created by RainHeroic Kung on 2017/9/7.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import "VerticalPostionLabel.h"

@implementation VerticalPostionLabel

@synthesize verticalAlignment = verticalAlignment_;

- (id)init {
    if (self = [super init]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}


- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
