//
//  TimeBankViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/24.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"
#import "TimeBankTableViewCell.h"
@interface TimeBankViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView * tableView;
@end
