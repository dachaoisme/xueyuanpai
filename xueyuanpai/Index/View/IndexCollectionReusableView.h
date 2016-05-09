//
//  IndexCollectionReusableView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexCollectionReusableViewDelegate <NSObject>

-(void)selectedImageIndex:(NSInteger)index;

@end


@interface IndexCollectionReusableView : UICollectionReusableView

@property(nonatomic, assign)id<IndexCollectionReusableViewDelegate> delegate;
@property(nonatomic, strong)NSArray * imageArray;


@end
