//
//  NSTimer+Addition.h
//  KLRecreationFamily
//
//  Created by 王园园 on 16/11/18.
//  Copyright © 2016年 Wangyuanyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
