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



///文本的标题
@property (nonatomic,strong)UILabel * titileLable;

///图片的label
@property (nonatomic,strong)UIImageView *showImageView;

///查看更多
@property (nonatomic,strong)UIButton * button;


@end
