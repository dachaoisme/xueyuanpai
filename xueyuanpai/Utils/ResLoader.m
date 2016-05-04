//
//  ResLoader.m
//  PanoTrip
//
//  Created by 建强 孙 on 14-1-28.
//  Copyright (c) 2014年 建强 孙. All rights reserved.
//

#import "ResLoader.h"

@implementation ResLoader

+(UIImage *)loadImage:(NSString *)name{
    return [ResLoader loadImage:name useDefault:YES];
}

+(UIImage *)loadImage:(NSString *)name useDefault:(BOOL)use{
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *iname = nil;
    NSString *iextend = nil;
    if ([arr count] == 2) {
        iname = [arr objectAtIndex:0];
        iextend = [arr objectAtIndex:1];
    }else{
        iname = name;
        iextend = @"png";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:iname ofType:iextend];
    if (!path) {
        if ([CommonUtils checkFileExistByName:name]) {
            path = [CommonUtils dataFilePathWithName:name];
        }else if(use){
            path = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
        }else{
            return nil;
        }
    }
    
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

+(UIImage *)loadImage:(NSString *)name extend:(NSString *)extend{
    return [ResLoader loadImage:name extend:extend useDefault:YES];
}

+(UIImage *)loadImage:(NSString *)name extend:(NSString *)extend useDefault:(BOOL)use{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extend];
    if (!path) {
        if ([CommonUtils checkFileExistByName:[NSString stringWithFormat:@"%@.%@", name, extend]]) {
            path = [CommonUtils dataFilePathWithName:[NSString stringWithFormat:@"%@.%@", name, extend]];
        }else if(use){
            path = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
        }else{
            return nil;
        }
    }
    
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

+(NSString *)loadJson:(NSString *)name{
    
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *iname = nil;
    NSString *iextend = nil;
    if ([arr count] == 2) {
        iname = [arr objectAtIndex:0];
        iextend = [arr objectAtIndex:1];
    }else{
        iname = name;
        iextend = @"json";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:iname ofType:iextend];
    
    if (!path) {
        if ([CommonUtils checkFileExistByName:name]) {
            return [NSString stringWithContentsOfFile:[CommonUtils dataFilePathWithName:name] encoding:NSUTF8StringEncoding error:nil];
        }
    }else{
        return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    
    return nil;
}

@end
