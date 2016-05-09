//
//  IndexIntegralMallCollectionReusableView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/9.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexIntegralMallCollectionReusableViewDelegate <NSObject>

-(void)getMoreIntegralMall;

@end


@interface IndexIntegralMallCollectionReusableView : UICollectionReusableView

@property(nonatomic, assign)id<IndexIntegralMallCollectionReusableViewDelegate> delegate;




@end
