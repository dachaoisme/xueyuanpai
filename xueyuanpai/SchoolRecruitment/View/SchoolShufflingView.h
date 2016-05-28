//
//  SchoolShufflingView.h
//  xueyuanpai
//
//  Created by 王园园 on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SchoolShufflingViewDelegate <NSObject>

-(void)selectedImageIndex:(NSInteger)index;

@end


@interface SchoolShufflingView : UIView

@property(nonatomic, assign)id<SchoolShufflingViewDelegate> delegate;
@property(nonatomic, strong)NSArray * imageArray;


@end
