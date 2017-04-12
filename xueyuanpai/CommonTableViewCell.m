//
//  CommonTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/8.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "CommonTableViewCell.h"


@implementation CommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createContenView];
    }
    
    return self;
}

- (void)createContenView{
    
    
    //擅长领域
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 180, 20)];
    titleLabel.text = @"擅长辅导领域";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [CommonUtils colorWithHex:@"666666"];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    //
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 - 15, 15, 100, 20)];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.text = @"选填";
    rightLabel.font = [UIFont systemFontOfSize:12];
    rightLabel.textColor = [CommonUtils colorWithHex:@"c7c6cb"];
    [self.contentView addSubview:rightLabel];
    self.rightLabel = rightLabel;
    
    //意见反馈
    JKPlaceholderTextView *textView = [[JKPlaceholderTextView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(titleLabel.frame) + 5, SCREEN_WIDTH-30, 60)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.placehoderText = @"你有什么意见或建议？";
    [textView setPlacehoderTextLabelTextColor:[CommonUtils colorWithHex:@"c7c6cb"]];
    [self.contentView addSubview:textView];
    self.textView = textView;

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
