//
//  JMCollectCourierListTableViewCell.h
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCollectCourierListTableViewCell : UITableViewCell


///显示快递运单号信息的label
@property (nonatomic,strong)UILabel *showCourierNumberLabel;

///当前快递的状态
@property (nonatomic,strong)UILabel *showStatuesLabel;

///入库的站点的label
@property (nonatomic,strong)UILabel *showSiteLabel;

///放入快递柜信息的label
@property (nonatomic,strong)UILabel *showExpressArkLabel;


///已取件状态的label【与快递柜信息的label的frame相同，只需隐藏上一个保存下一个即可】
@property (nonatomic,strong)UILabel *showHaveTakeLabel;

@end
