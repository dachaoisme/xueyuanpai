//
//  AboutUsViewController.m
//  xueyuanpai
//
//  Created by 王园园 on 16/6/6.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "AboutUsViewController.h"

#import "AboutUsTableViewCell.h"

@interface AboutUsViewController ()


@property (nonatomic,strong)NSDictionary *dataDic;


@property (nonatomic,strong)UIButton *callButton;

///学习图片
@property (nonatomic,strong)UIImageView *studyImageView;

///标题
@property (nonatomic,strong)UILabel *titleLabel ;

///内容
@property (nonatomic,strong)UILabel *contentLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataDic = [NSDictionary dictionary];
    
    self.title = @"关于我们";
    
    [self createLeftBackNavBtn];
    
    [self createView];
    
    [self requestCallInformation];

    
}

#pragma mark - 创建View
- (void)createView{
    
    UIImageView *studyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, NAV_TOP_HEIGHT+20, 60, 60)];
    studyImageView.image = [UIImage imageNamed:@"about_logo"];
    [self.view addSubview:studyImageView];
    self.studyImageView = studyImageView;
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, CGRectGetMaxY(studyImageView.frame), 100, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH - 30, 50)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[CommonUtils colorWithHex:@"00beaf"]];
    [submitBtn setFrame:CGRectMake(15, CGRectGetMaxY(contentLabel.frame), SCREEN_WIDTH - 30,48)];
    submitBtn.layer.cornerRadius = 10.0;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    self.callButton = submitBtn;

    

}

#pragma mark - 请求关于我们详情信息
- (void)requestCallInformation{
    
    
    /*
     
     关于我们
     接口地址 ：v1/aboutus/index
     参数: 无
     返回结果:
     {
     "stat":1,
     "msg":"succ",
     "data":{
     "title":"\u5173\u4e8e\u6211\u4eec\u4e0a\u5e02",
     "telphone":"400-123-123-123",
     "content":" 2015\u5e744\u670828\u65e5\uff0c\u4e60\u8fd1\u"}
     }
     
     
     */
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpClient sharedInstance]aboutUsWithParams:dic withSuccessBlock:^(HttpResponseCodeModel *model) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model.responseCode ==ResponseCodeSuccess) {
            ///请求成功
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            
            self.dataDic = model.responseCommonDic;
        
            NSString *phoneNumber = [self.dataDic objectForKey:@"telphone"];

            [self.callButton setTitle:[NSString stringWithFormat:@"联系我们%@",phoneNumber] forState:UIControlStateNormal];
            
            
            self.titleLabel.text = [self.dataDic objectForKey:@"title"];
            

            NSString *content = [self.dataDic objectForKey:@"content"];
            
            self.contentLabel.frame =   CGRectMake(15, CGRectGetMaxY(_titleLabel.frame), SCREEN_WIDTH - 30, [self textHeight:[self.dataDic objectForKey:@"content"]]);
            
            
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            self.contentLabel.attributedText = attrStr;

            [self.callButton setFrame:CGRectMake(15, CGRectGetMaxY(_contentLabel.frame), SCREEN_WIDTH - 30,48)];


        }else{
            ///反馈失败
            [CommonUtils showToastWithStr:model.responseMsg];
        }
    } withFaileBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    


    
}

#pragma mark - 联系我们按钮
- (void)contactAction{
    
    NSString *phoneNumber = [self.dataDic objectForKey:@"telphone"];
    
    [CommonUtils callServiceWithTelephoneNum:phoneNumber];
    
}

//自适应撑高
//计算字符串的frame
- (CGFloat)textHeight:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    //返回计算好的高度
    return rect.size.height;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
