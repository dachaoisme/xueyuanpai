//
//  TimeBankDetailTwoStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/29.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TimeBankDetailTwoStyleTableViewCellDelegate <NSObject>

- (void)addComment;

@end

@interface TimeBankDetailTwoStyleTableViewCell : UITableViewCell

///头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

///昵称
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

///聊天内容
@property (weak, nonatomic) IBOutlet UILabel *contactContentLabel;

///聊天时间
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

///添加评论按钮
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;




@property (nonatomic,assign)id<TimeBankDetailTwoStyleTableViewCellDelegate>delegate;
@end
