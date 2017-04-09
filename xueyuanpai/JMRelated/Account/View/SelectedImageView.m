//
//  SelectedImageView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SelectedImageView.h"
//#import "AddStudentInfoViewController.h"
@interface SelectedImageView ()

{
    UIControl * control;
    UIImagePickerController *thePicker;
    UIViewController * superController;
}

@end

@implementation SelectedImageView


-(instancetype)initWithFrame:(CGRect)frame withSuperController:(UIViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        superController = controller;
        [self setContentViewWithFrame:frame];
    }
    return self;
}

-(void)setContentViewWithFrame:(CGRect)frame
{
    float space = 5;
    float width = frame.size.width;
    float height = (frame.size.height-space)/3;
    UIButton * manBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"从相册上传" fontSize:15 frame:CGRectMake(0,0 , width, height)];
    [manBtn setBackgroundColor:[UIColor whiteColor]];
    manBtn.tag = 10001;
    manBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [manBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:manBtn];
    
    UIButton * womanBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"拍照" fontSize:15 frame:CGRectMake(0,CGRectGetMaxY(manBtn.frame), width, height)];
    [womanBtn setBackgroundColor:[UIColor whiteColor]];
    womanBtn.tag = 10002;
    womanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [womanBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:womanBtn];
    
    UIButton * cancelBtn = [UIFactory button:nil sel:nil titleColor:@"333333" title:@"取消" fontSize:15 frame:CGRectMake(0,CGRectGetMaxY(womanBtn.frame)+space, width, height)];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    cancelBtn.tag = 10003;
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cancelBtn addTarget:self action:@selector(selectedSxe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    [UIFactory showLineInView:self color:@"e5e5e5" rect:CGRectMake(0, CGRectGetMaxY(manBtn.frame)-0.25, SCREEN_WIDTH, 0.5)];
    control = [UIFactory contolBackgroundWithAlph:0.5];
    control.backgroundColor = [UIColor blackColor];
    
}

-(void)selectedSxe:(UIButton *)sender
{
    if (sender.tag ==10001) {
        //从相册上传
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self initPickWithSourcheType:sourcheType];
    }else if (sender.tag ==10002){
        //拍照
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
        [self initPickWithSourcheType:sourcheType];
    }else{
        //取消
        
    }
    [control removeFromSuperview];
    [self removeFromSuperview];
}

-(void)initPickWithSourcheType:(UIImagePickerControllerSourceType)sourcheType
{
    if (!thePicker) {
        thePicker = [[UIImagePickerController alloc]init];
        thePicker.view.backgroundColor = [UIColor orangeColor];
        //UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
        //thePicker.sourceType = sourcheType;
        thePicker.delegate = self;
        thePicker.allowsEditing = YES;
    }
    thePicker.sourceType = sourcheType;
    
    
    [superController presentViewController:thePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.callBackBlock(selectedImage);
    [superController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
