//
//  VerticalPostionLabel.h
//  teacherTrains
//
//  Created by RainHeroic Kung on 2017/9/7.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface VerticalPostionLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;


@end
