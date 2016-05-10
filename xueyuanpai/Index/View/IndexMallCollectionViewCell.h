//
//  IndexMallCollectionViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexMallModel.h"
@interface IndexMallCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView * mallImageView;
@property(nonatomic,strong)UILabel     * mallTitileLable;
@property(nonatomic,strong)UILabel     * mallIntegralTitileLable;

-(void)setContentViewWithModel:(IndexMallModel *)model;

@end
