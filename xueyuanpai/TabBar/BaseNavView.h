//
//  BaseNavView.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseNavViewDelegate <NSObject>

@optional

-(void)isSelectedBroadcastWithBool:(BOOL)yesBroadcast;//是否是广播
@end

@interface BaseNavView : UIView
{
    UILabel *titLab;
    UIButton *backBtn;
    UIButton *rightBtn;
    UILabel * badgeLab;
    UILabel * rightLab;
    NSMutableDictionary* rightItems;
    NSMutableDictionary* leftItems;
    
    UIButton * broadcastBtn;//私信按钮
    UIButton * chatBtn;//广播按钮
    
    UIButton * userDefinedLeftBtn;//自定义的左侧的按钮，如首页的“我的按”钮
}
@property(nonatomic,strong)UIButton * backBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@property(nonatomic,strong)id<BaseNavViewDelegate>delegate;
#pragma mark - 新添加
//自定义左侧按钮事件
-(void)setUserDefinedLeftBtnWithTitle:(NSString *)title withTarget:(id)target selected:(SEL)selected;
-(void)setUserDefinedLeftBtnWithImage:(NSString *)imageName withTarget:(id)target selected:(SEL)selected;
-(void)setUserDefineLeftReturnBtn;


#pragma mark - 原来有的
-(id)initWithTitle:(NSString *)title background:(NSString*)bgImage;
-(id)initWithTitle:(NSString *)title color:(NSString *)color;

//收件箱中，导航栏包括两个标签，分别是广播和私信页
-(id)initInboxNavigationBarWithcolor:(NSString *)color withIsBroadcast:(BOOL)isBroadcast;
-(void)setInboxLeft;
-(void)setRightItem:(id)right target:(id)target selector:(SEL)selector;

// 这个方法只是临时使用。。。。坑爹。。。。
-(void)tmpSetRightItem:(id)right target:(id)target selector:(SEL)selector withScale:(NSInteger)scale;

-(void)setLeft;
-(void)setLeft:(NSString*)imageName;
-(void)setRightBadge:(int)number;
-(void)setBackTarget:(id)target selector:(SEL)selector;
-(void)setTitle:(NSString *)title;
- (void)titleLabelHidden:(BOOL)hidden;       //隐藏顶部标题
-(void)setRithtTitle:(NSString *)title;
-(void)setTitleColor:(NSString *)color;
-(void)setRightColor:(NSString *)color;
-(void)clearBackgroundColor;
-(void)setRightHidden:(BOOL)isHidden;
/**
 * 第一个参数事件target,第二个参数为控件资源,第三个参数为控件的tag,第三个参数为控件的tap事件...
 * 如果一个控件由图文组成,请传递图片名称,文字，图文的顺序以显示顺序为准,资源图片请以.png或者.jpg结尾，否则当文字处理
 * 调用此方法不能同时调用setRightButton相关的方法，否则此方法无准备。
 * eg.
 * [setRightWithObjectsAndSelectors:self,@"xx.png,选择",tag,@selector(sssss:),nil]
 */
-(void)setRightWithObjectsAndSelectors:(id)target, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *index是你传的资源从左到右的顺序的编号,最左边是1,依次是2,3,...
 *当你传的资源是以","分隔的多个资源组合时，其中的每一个资源也是从左至右依次编码的
 */
-(id)getRightObjectAtIndex:(uint)index;
/**
 * 第一个参数事件target,第二个参数为控件资源,第三个参数为控件的tag,第三个参数为控件的tap事件...
 * 如果一个控件由图文组成,请传递图片名称,文字，图文的顺序以显示顺序为准,资源图片请以.png或者.jpg结尾，否则当文字处理
 * 调用此方法不能同时调用setRightButton相关的方法，否则此方法无准备。
 * eg.
 * [setRightWithObjectsAndSelectors:self,@"xx.png,选择",tag,@selector(sssss:),nil]
 */
-(void)setLeftWithObjectsAndSelectors:(id)target, ... NS_REQUIRES_NIL_TERMINATION;
/**
 *index是你传的资源从左到右的顺序的编号,最左边是1,依次是2,3,...
 *当你传的资源是以","分隔的多个资源组合时，其中的每一个资源也是从左至右依次编码的
 */
-(id)getLeftObjectAtIndex:(uint)index;

-(void)setCustomTitleSubLeftTitle:(NSString *)str1 color:(UIColor *)colorL SubRightTitle:(NSString*)str2 color:(UIColor *)colorR;

@end
