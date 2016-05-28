//
//  SchoolShufflingView.m
//  xueyuanpai
//
//  Created by 王园园 on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "SchoolShufflingView.h"

#import "IndexScrollView.h"
@interface SchoolShufflingView ()
{
    IndexScrollView *scrollV;
}


@end

@implementation SchoolShufflingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentView];
    }
    
    return self;
}

-(void)setContentView
{
    
    scrollV = [[IndexScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 150)];
    scrollV.pics = _imageArray;
    [self addSubview:scrollV];
    //点击事件
    weakSelf(weakSelf);
    [scrollV returnIndex:^(NSInteger index) {
        NSLog(@"点击了第%zi张", index);
        if ([weakSelf.delegate respondsToSelector:@selector(selectedImageIndex:)]) {
            [weakSelf.delegate selectedImageIndex:index];
        }
    }];
    //刷新（必需的步骤）
    [scrollV reloadView];
}
-(void)setImageArray:(NSArray *)imageArray
{
    scrollV.pics = imageArray;
    [scrollV reloadView];
}

@end
