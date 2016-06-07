//
//  MineOneStyleTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/6/7.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineOneStyleTableViewCellDelegate <NSObject>

- (void)leftAction;

- (void)rightAction;

@end

@interface MineOneStyleTableViewCell : UITableViewCell


@property (nonatomic,assign)id<MineOneStyleTableViewCellDelegate>delegate;



@end
