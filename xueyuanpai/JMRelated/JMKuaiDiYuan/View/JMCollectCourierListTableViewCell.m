//
//  JMCollectCourierListTableViewCell.m
//  xueyuanpai
//
//  Created by 王园园 on 2017/4/13.
//  Copyright © 2017年 lidachao. All rights reserved.
//

#import "JMCollectCourierListTableViewCell.h"

@implementation JMCollectCourierListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initContentCell];
    }
    return self;
}


- (void)initContentCell{
    
    ///顶部展示快递信息的label
    if (_showCourierNumberLabel == nil) {
        _showCourierNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, 200, 16)];
        _showCourierNumberLabel.font = [UIFont systemFontOfSize:14];
        _showCourierNumberLabel.text = @"圆通66666666";
        _showCourierNumberLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        [self.contentView addSubview:_showCourierNumberLabel];
    }
    

    //快递状态
    if (_showStatuesLabel == nil) {
        _showStatuesLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100 - 15, 20, 100, 14)];
        _showStatuesLabel.font = [UIFont systemFontOfSize:12];
        _showStatuesLabel.text = @"等待取件";
        _showStatuesLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        _showStatuesLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_showStatuesLabel];
    }
    
    //站点信息展示
    if (_showSiteLabel == nil) {
        _showSiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_showCourierNumberLabel.frame) + 10, 200, 16)];
        _showSiteLabel.font = [UIFont systemFontOfSize:14];
        _showSiteLabel.text = @"    已入库站点A";
        _showSiteLabel.textColor = [CommonUtils colorWithHex:@"b4b4b4"];
        [self.contentView addSubview:_showSiteLabel];
    }
    
    //创建入库站点左边的灰色圆点
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 6, 6)];
    circleView.backgroundColor = [CommonUtils colorWithHex:@"d8d8d8"];
    circleView.layer.cornerRadius = 3;
    circleView.layer.masksToBounds = YES;
    [_showSiteLabel addSubview:circleView];
    
    
    //快递柜信息展示
    if (_showExpressArkLabel == nil) {
        _showExpressArkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_showSiteLabel.frame) + 10, SCREEN_WIDTH - 20 - 15, 16)];
        _showExpressArkLabel.font = [UIFont systemFontOfSize:14];
        _showExpressArkLabel.text = @"    已放入A区1号柜，取货码32345";
        _showExpressArkLabel.textColor = [CommonUtils colorWithHex:@"00c05c"];
        [self.contentView addSubview:_showExpressArkLabel];
    }


    //快递柜圆点
    UIView *circleView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 6, 6)];
    circleView1.backgroundColor = [CommonUtils colorWithHex:@"00c05c"];
    circleView1.layer.cornerRadius = 3;
    circleView1.layer.masksToBounds = YES;
    [_showExpressArkLabel addSubview:circleView1];
    
    
    
    if (_showHaveTakeLabel == nil) {
        _showHaveTakeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_showSiteLabel.frame) + 10, SCREEN_WIDTH - 20 - 15, 16)];
        _showHaveTakeLabel.font = [UIFont systemFontOfSize:14];
        _showHaveTakeLabel.text = @"    已取件";
        _showHaveTakeLabel.textColor = [CommonUtils colorWithHex:@"666666"];
        _showHaveTakeLabel.hidden = YES;
        [self.contentView addSubview:_showHaveTakeLabel];
    }

    
    //已取件的图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 9, 9)];
    imageView.image = [UIImage imageNamed:@"msg_check"];
    [_showHaveTakeLabel addSubview:imageView];
    

    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
