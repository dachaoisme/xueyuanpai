//
//  JMHomePageTwoTypeTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 17/4/10.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMHomePageTwoTypeTableViewCellDelegate <NSObject>

- (void)seeMoreProjectAction;

@end

@interface JMHomePageTwoTypeTableViewCell : UITableViewCell


@property (nonatomic,assign)id <JMHomePageTwoTypeTableViewCellDelegate>delegate;

@end
