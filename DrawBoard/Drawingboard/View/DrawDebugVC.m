//
//  DrawDebugVC.m
//  yfd
//
//  Created by 1696477589@qq.com on 2017/5/11.
//  Copyright © 2017年 yj.com. All rights reserved.
//

#import "DrawDebugVC.h"

#import "DrawView.h"
#import "ZoomView.h"

@interface DrawDebugVC ()

@property (strong, nonatomic)DrawView *drawView;
@property (strong, nonatomic)ZoomView *zommView;

@end

@implementation DrawDebugVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupNaviLeftItem];
    
    [self setupNaviRightItem];
    
    ZoomView *zoomView = [[ZoomView alloc]initWithFrame:self.view.bounds];
    self.zommView = zoomView;
    self.drawView = zoomView.drawView;
    //
    //    DrawView *drawView = [[DrawView alloc]initWithFrame:self.view.bounds];
    //    self.drawView = drawView;
    
    [self.view addSubview:_zommView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidLayoutSubviews{
    NSLog(@"----------------->W:%f H:%f",self.view.frame.size.width,self.view.frame.size.height);
    
    [_zommView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}


- (void)setupNaviLeftItem{
    UIBarButtonItem *undo = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(clickLeftItemUndo:)];
    UIBarButtonItem *redo = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(clickLeftItemRedo:)];
    
    UIBarButtonItem *replay = [[UIBarButtonItem alloc]initWithTitle:@"Replay" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemReplay:)];
    
    UIBarButtonItem *start = [[UIBarButtonItem alloc]initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemStart:)];
    UIBarButtonItem *stop = [[UIBarButtonItem alloc]initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemStop:)];
    
    self.navigationItem.leftBarButtonItems = @[replay,undo,redo,start,stop];
}

- (void)setupNaviRightItem{
    UIBarButtonItem *undo = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(clickLeftItemUndo:)];
    UIBarButtonItem *redo = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(clickLeftItemRedo:)];
    
    UIBarButtonItem *replay = [[UIBarButtonItem alloc]initWithTitle:@"Replay" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemReplay:)];
    
    UIBarButtonItem *start = [[UIBarButtonItem alloc]initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemStart:)];
    UIBarButtonItem *stop = [[UIBarButtonItem alloc]initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItemStop:)];
    
    UIBarButtonItem *delete = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clickRightItem:)];
    
    self.navigationItem.rightBarButtonItems = @[delete,stop,start,redo,undo,replay];
}

- (void) clickLeftItemUndo:(id)seder{
    [self.drawView undoStep];
}
- (void) clickLeftItemRedo:(id)seder{
    [self.drawView redoStep];
}

- (void) clickLeftItemReplay:(id)seder{
    [self.drawView replay];
}

- (void) clickLeftItemStart:(id)seder{
    [self.drawView startRecord];
}

- (void) clickLeftItemStop:(id)seder{
    [self.drawView stopRecord];
}

- (void) clickRightItem:(id)seder{
    [self.drawView clearScreen];
}

@end
