//
//  JMCommentListTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/16.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCommentListTableViewCell : UITableViewCell

///头像
@property (nonatomic,strong)UIImageView *headImageView;

///是否显示认证图标
@property (nonatomic,strong)UIImageView *showCertificationImageView;


///昵称
@property (nonatomic,strong)UILabel *nickNameLabel;


///内容
@property (nonatomic,strong)UILabel *contentLabel;


///时间
@property (nonatomic,strong)UILabel *timeLabel;


@end
