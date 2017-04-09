//
//  SelectedSchollViewController.h
//  xueyuanpai
//
//  Created by lidachao on 16/5/22.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectedSchollViewController : BaseViewController<UISearchBarDelegate>


///选择性别的block
@property(nonatomic,copy)SelectedSchollBlock callBackBlock;
@end
