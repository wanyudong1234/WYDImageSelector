//
//  ViewController.m
//  WYDImageSelector
//
//  Created by wanyudong on 2018/2/1.
//  Copyright © 2018年 wanyudong. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionView.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ImageCollectionView *view = [[ImageCollectionView alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
