//
//  SudokuAddImageView.h
//  DownloadFile
//
//  Created by RainHeroic Kung on 2017/11/15.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SudokuAddImageView : UIView

/**  存储所有的照片(UIImage) */
@property (nonatomic, strong) NSMutableArray *images;


@property (nonatomic,assign) BOOL allowEdit;

@end
