//
//  ImageCollectionView.m
//  WYDImageSelector
//
//  Created by wanyudong on 2018/2/1.
//  Copyright © 2018年 wanyudong. All rights reserved.
//

#import "ImageCollectionView.h"
#import "ImageCollectionCell.h"
#import "LGPhoto.h"

@interface ImageCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, LGPhotoPickerViewControllerDelegate>

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *datas;
@property (nonatomic, assign) LGShowImageType showType;

@end

@implementation ImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageCollectionView = self.imageCollectionView;
    }
    return self;
}

#pragma mark - CollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.datas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionCell" forIndexPath:indexPath];
    
    cell.imageV.image = [_datas objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ([_datas count]-1)) {
        LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:LGShowImageTypeImagePicker];
        pickerVc.status = PickerViewShowStatusCameraRoll;
        pickerVc.maxCount = 9;   // 最多能选9张图片
        pickerVc.delegate = self;
        self.showType = LGShowImageTypeImagePicker;
        [pickerVc showPickerVc:self.viewController];
    }else {
        //退出
        UIAlertController *alertOut=[UIAlertController alertControllerWithTitle:@"确定删除吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureOut=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_datas removeObjectAtIndex:indexPath.row];
            [self.imageCollectionView reloadData];
        }];
        [alertOut addAction:cancel];
        [alertOut addAction:sureOut];
        [self.viewController presentViewController:alertOut animated:YES completion:nil];
        
    }
}

// 选择图片等回调方法
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    for (LGPhotoAssets* asset in assets) {
        if (asset != nil) {
            [_datas insertObject:asset.originImage atIndex:0];
        }
        continue;
    }
    [self.imageCollectionView reloadData];
}

- (UICollectionView *)imageCollectionView {
    if (_imageCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(70, 70);
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.backgroundColor = [UIColor whiteColor];
        
        [_imageCollectionView registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:@"ImageCollectionCell"];
        
        [self addSubview:_imageCollectionView];
    }
    return _imageCollectionView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        
        UIImage *addImg = [UIImage imageNamed:@"Image_Add"];
        _datas = [[NSMutableArray alloc] initWithObjects:addImg, nil];
    }
    return _datas;
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
