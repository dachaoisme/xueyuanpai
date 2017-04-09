//
//  SelectedImageView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedImageView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

///选择性别的block
@property(nonatomic,copy)SelectedImageBlock callBackBlock;

-(instancetype)initWithFrame:(CGRect)frame withSuperController:(UIViewController *)controller;
@end
