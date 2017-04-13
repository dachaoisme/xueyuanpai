//
//  CommentInputView.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/10/10.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentInputViewDelegate <NSObject>

-(void) onCommentCreate:(long long ) commentId text:(NSString *) text;


@end




@interface CommentInputView : UIView


@property (nonatomic, weak) id<CommentInputViewDelegate> delegate;

@property (nonatomic, assign) long long commentId;

///评论的类型：1-feed评论，2-对评论的评论
@property (nonatomic, strong) NSString *commentType;


///评论需要的targetID
@property (nonatomic, strong) NSString *commentTargetID;

///评论的textView
@property (strong,nonatomic) UITextField *inputTextView;


-(void) addNotify;

-(void) removeNotify;

-(void) addObserver;

-(void) removeObserver;

-(void) show;

-(void) setPlaceHolder:(NSString *) text;

@end
