//
//  ExpressCenterViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpressCenterModel.h"

#import "XHRadarView.h"
@interface ExpressCenterViewController : BaseViewController<XHRadarViewDataSource, XHRadarViewDelegate>

@property (nonatomic, strong) XHRadarView *radarView;

@end
