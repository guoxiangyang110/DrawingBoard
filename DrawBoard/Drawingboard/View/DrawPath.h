//
//  DrawPath.h
//  drawBoard
//
//  Created by dengwei on 15/6/27.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawPath:NSObject

+(id)drawPathWithCGPath:(CGPathRef)drawPath
                  color:(NSString *)color
              lineWidth:(CGFloat)lineWidth;

@property (strong, nonatomic)UIBezierPath *drawPath;
@property (copy, nonatomic)NSString *drawColor;
@property (assign, nonatomic)CGFloat lineWidth;

//用户选择的图像
@property (strong, nonatomic)UIImage *image;

@property (assign, nonatomic)long date;

@property (assign, nonatomic)double x;
@property (assign, nonatomic)double y;
@property (assign, nonatomic)long long identifier;

@property (strong, nonatomic)NSMutableArray *vertexList;

@end
