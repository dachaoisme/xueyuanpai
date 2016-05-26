//
//  SchoolColumnView.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IndexColumnsModel.h"
@interface SchoolColumnView : UIView

@property(nonatomic,strong)UIImageView * columnImageView;
@property(nonatomic,strong)UILabel     * columnTitileLable;

-(void)setContentViewWithModel:(IndexColumnsModel *)model;

@end
