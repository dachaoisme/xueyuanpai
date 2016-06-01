//
//  PhotoSelectorCell.m
//  PhotoPicker
//
//  Created by yangtao on 3/1/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

#import "PhotoSelectorCell.h"
#import "Masonry.h"

@interface PhotoSelectorCell()
///添加按钮
@property (nonatomic, strong) UIButton *addButton;
///移除按钮
@property (nonatomic, strong) UIButton *removeButton;

@end

@implementation PhotoSelectorCell


- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    if (_image != nil) {
        
        self.removeButton.hidden = NO;
        [self.addButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }else {
    
        self.removeButton.hidden = YES;
        [self.addButton  setBackgroundImage:[UIImage imageNamed:@"market_post_add_pic"] forState: UIControlStateNormal];
    }
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UIButton *addButton = [[UIButton alloc] init];
    addButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [addButton setBackgroundImage:[UIImage imageNamed:@"market_post_add_pic"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"market_post_add_pic_press"] forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    self.addButton = addButton;

    
    UIButton *removeButton = [[UIButton alloc] init];
    [removeButton setBackgroundImage:[UIImage imageNamed:@"market_post_pic_delete"] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
    self.removeButton = removeButton;
    
    
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak __typeof(&*self)weakSelf = self;
   [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.height.equalTo(weakSelf);
       
       
       make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(10);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
   }];
    
    [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(10);
        make.top.equalTo(weakSelf.contentView.mas_top);
    
    }];
    
}

- (void)addBtnClick {
    
    if (!self.image) {//添加图片
        if ([self.PhotoCelldelegate respondsToSelector:@selector(photoDidAddSelector:)]) {
            [self.PhotoCelldelegate photoDidAddSelector:self];
        }
    }else {
        
        NSLog(@"点击放大");
    }
  
}

- (void)removeBtnClick {
    
    
    if ([self.PhotoCelldelegate respondsToSelector:@selector(photoDidRemoveSelector:)]) {
        [self.PhotoCelldelegate photoDidRemoveSelector:self];
    }
}
@end
