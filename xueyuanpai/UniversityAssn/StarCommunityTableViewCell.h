//
//  StarCommunityTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/21.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotActivityModel;
@interface StarCommunityTableViewCell : UITableViewCell

- (void)bindModel:(HotActivityModel *)model;

@end
