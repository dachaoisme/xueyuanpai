//
//  IndexColumnCollectionViewCell.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/10.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexColumnsModel.h"
@interface IndexColumnCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView * columnImageView;
@property(nonatomic,strong)UILabel     * columnTitileLable;

-(void)setContentViewWithModel:(IndexColumnsModel *)model;
@end
