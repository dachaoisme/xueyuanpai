//
//  LDCPullDownMenuView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/25.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDCPullDownMenuView;

typedef enum
{
    IndicatorStateShow = 0,
    IndicatorStateHide
}
IndicatorStatus;

typedef enum
{
    BackGroundViewStatusShow = 0,
    BackGroundViewStatusHide
}
BackGroundViewStatus;

@protocol LDCPullDownMenuViewDelegate <NSObject>

- (void)PullDownMenu:(LDCPullDownMenuView *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row;

@end


@interface LDCPullDownMenuView : UIView<UITableViewDelegate, UITableViewDataSource>

- (LDCPullDownMenuView *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color withFrame:(CGRect)frame;

@property (nonatomic) id<LDCPullDownMenuViewDelegate> delegate;

@end

// CALayerCategory
@interface CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath;

@end
