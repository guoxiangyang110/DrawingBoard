//
//  ZoomView.m
//  aa
//
//  Created by 1696477589@qq.com on 2017/5/2.
//  Copyright © 2017年 com.yqj. All rights reserved.
//

#import "ZoomView.h"
#import "DrawingboardScoll.h"

@interface ZoomView ()<UIScrollViewDelegate>
@property (nonatomic,strong) DrawingboardScoll *scrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ZoomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _scrollView = [[DrawingboardScoll alloc] init];
        [_scrollView setFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 3;
        _scrollView.minimumZoomScale = 1;
        _scrollView.bounces = NO;
        _scrollView.bouncesZoom = NO;
        
        _scrollView.scrollEnabled = YES;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        
        [self addSubview:_scrollView];
        
        _contentView = [[UIView alloc] init];
        [_scrollView addSubview:_contentView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _imageView.image = [UIImage imageNamed:@"launch_image"];
        _imageView.multipleTouchEnabled = NO;
        [_contentView addSubview:_imageView];
        
        DrawView *drawView = [[DrawView alloc]initWithFrame:self.bounds];
        drawView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.drawView = drawView;
        
        [_contentView addSubview:_drawView];

    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.scrollView.zoomScale<1.1 && self.scrollView.zoomScale>0.9) {
        
        _scrollView.frame = self.bounds;
        _contentView.frame = _scrollView.bounds;
        _imageView.frame = _contentView.bounds;
        _scrollView.contentSize = _contentView.bounds.size ;
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.contentView;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"%s",__func__);
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s",__func__);
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%s",__func__);
}

@end
