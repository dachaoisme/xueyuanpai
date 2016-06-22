//
//  NSTimer+Addition.h
//  mall
//
//  Created by 王少刚 on 14-5-7.
//  Copyright (c) 2014年 北京九点动力网络技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
