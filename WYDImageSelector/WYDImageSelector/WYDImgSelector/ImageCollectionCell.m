//
//  ImageCollectionCell.m
//  WYDImageSelector
//
//  Created by wanyudong on 2018/2/1.
//  Copyright © 2018年 wanyudong. All rights reserved.
//

#import "ImageCollectionCell.h"

@implementation ImageCollectionCell

- (UIImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        _imageV.frame = CGRectMake(5, 5, 60, 60);
        [self.contentView addSubview:_imageV];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return _imageV;
}

@end
