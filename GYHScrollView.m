//
//  GYHScrollView.m
//  1 3个iamgeView无限滚动
//
//  Created by 千锋 on 16/3/2.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "GYHScrollView.h"

#define ImageView_tag 100 //定义宏

@interface GYHScrollView ()<UIScrollViewDelegate>//遵守 协议
@end

@implementation GYHScrollView
{
    UIScrollView * _scrollView;
    //图片数组
    NSMutableArray * _imgArray;
}
//创建❤️一个视图，必定会调用这个方法
//在这儿，做一些初始化工作
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //1.scrollView
        _scrollView = [[UIScrollView alloc] init];
        //设置分页
        _scrollView.pagingEnabled = YES;
        //设置代理
        _scrollView.delegate = self;
        
       [self addSubview:_scrollView];
        //2.创建三个imageView
        for (int i = 0; i < 3; i ++) {
            UIImageView * imageView = [[UIImageView alloc]init];
            imageView.tag = ImageView_tag + i;
            [_scrollView addSubview:imageView];
        }
    }
    return self;
}

//当前控件将要显示在屏幕上的时候，会调用
//一般在这个方法中，数组子视图的frame❤️
-(void)layoutSubviews
{
    //1.设置视图的frame
    _scrollView.frame = self.bounds;//❤️bounds替代frame，frame❤️相对父试图。
    
    NSLog(@"%@", self);
    NSLog(@"%f%f", self.frame.origin.x, self.frame.origin.y);
    
    //2.设置滚动视图的内容大小(三倍的滚动视图frame的宽度，因为我们确定了只放三个❤️图片视图ImageView)
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*3, _scrollView.frame.size.height);
    
    //3.设置 创建的显示图片的三个imageView的frame
    for (int i = 0; i < 3; i ++) {
        //A.拿到对应的imageView
        UIImageView * imageView = (UIImageView *)[_scrollView viewWithTag:ImageView_tag+i];
        //B.设置frame
        imageView.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        //C.设置 显示的图片
        if (i == 0) {
            //第一个imageView❤️显示最后一张图片
            imageView.image = _imgArray[_imgArray.count - 1];
        }else{
            imageView.image = _imgArray[i - 1];
        }
        //D.设置偏移量，使其显示❤️中间的图片
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    }
   
}

//实现传图片的方法，在这儿将图片名转换成❤️图片保存下来
-(void)imageNames:(NSArray *)imageNames
{
    //先移除图片数组中的内容
    //如果图片数组不为空，将图片数组中内容清空
    if (_imgArray) {//判断数组 ❤️是否为空
        [_imgArray removeAllObjects];
    }else{
        _imgArray = [[NSMutableArray alloc]init];
    }
    
    for (NSString * imageName in imageNames) {
        //拿到❤️包中指定❤️文件的路径
        NSString * imagePath = [[NSBundle mainBundle]pathForResource:imageName ofType:nil];
        //创建图片  (和内存相关,根据内存空间的浪费程度，选择图片创建方法)
        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
        //将图片存入数组
        [_imgArray addObject:image];
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //拿到停止滑动后，当前显示的是哪个imageView(0,1,2)  ❤️下标
    int imageViewIndex = (int)scrollView.contentOffset.x/scrollView.frame.size.width;
    //拿到 当前显示图片的imageView
    UIImageView * imageView = (UIImageView *)[_scrollView viewWithTag:ImageView_tag + imageViewIndex];
    //拿到 当前❤️imageView上显示图片对应的下标
    NSInteger imageIndex = [_imgArray indexOfObject:imageView.image];
    
    
    if (1) {//imageViewIndex == 2
        //A.把 中间的imageView上的图片换成当前的图片
        UIImageView * middleImageView = (UIImageView *)[_scrollView viewWithTag:ImageView_tag + 1];
        //如果 当前图片(❤️下标) 为 最后一张
        UIImageView * lastImageView = (UIImageView *)[_scrollView viewWithTag:ImageView_tag + 2];
        //如果  当前图片(下标) 为 第一张
        UIImageView * firstImageView = (UIImageView *)[_scrollView viewWithTag:ImageView_tag + 0];
        
        middleImageView.image = imageView.image;
        
        //B.设置偏移量,使中间的图片显示出来
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
        //C.换第一个imageView和第三个imageView的 图片
        //a.如果当前显示的是最后一张图片
        if (imageIndex == _imgArray.count - 1) {
            lastImageView.image = _imgArray[0];
            firstImageView.image = _imgArray[imageIndex - 1];//前面的图片仍然为之前❤️的那张
            
//            imageView.image = _imgArray[0];
        }else if(imageIndex == 0){
            firstImageView.image = _imgArray[_imgArray.count - 1];
            lastImageView.image = _imgArray[imageIndex + 1];
            
//            imageView.image = [_imgArray lastObject];
        }else{
            firstImageView.image = _imgArray[imageIndex - 1];
            lastImageView.image = _imgArray[imageIndex + 1];
        }
        
        
    }
    
    
}



@end
