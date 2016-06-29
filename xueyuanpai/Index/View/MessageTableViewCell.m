//
//  MessageTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/28.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createContentView];
        
    }
    
    return self;
}

#pragma mark - 创建当前视图
- (void)createContentView{
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
    [self.contentView addSubview:leftImageView];
    self.leftImageView = leftImageView;
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame) + 15, CGRectGetMinY(leftImageView.frame) + 10, 250, 30)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    
    self.badgeView = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 20, 25, 25) dragdropCompletion:^{
        NSLog(@"TableViewCell drag done.");
    }];
    
    self.badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:self.badgeView];

    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
