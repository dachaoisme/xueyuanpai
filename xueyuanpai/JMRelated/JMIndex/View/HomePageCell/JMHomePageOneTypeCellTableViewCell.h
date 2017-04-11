//
//  JMHomePageOneTypeCellTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMHomePageOneTypeCellTableViewCellDelegate <NSObject>

///集梦创客的点击事件
- (void)tapDreamGuestAction;

///集梦空间的点击事件
- (void)tapDreamSpaceAction;

@end

@interface JMHomePageOneTypeCellTableViewCell : UITableViewCell

@property (nonatomic,assign)id<JMHomePageOneTypeCellTableViewCellDelegate>delegate;

@end
