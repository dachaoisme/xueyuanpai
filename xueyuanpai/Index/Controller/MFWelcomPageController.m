//
//  MFWelcomPageController.m
//  MFWelcomePageController
//
//  Created by lanjiying on 16/7/25.
//  Copyright © 2016年 lanjiying_Anna. All rights reserved.
//

#import "MFWelcomPageController.h"
#import "CommonUtils.h"
#define PAGESNUMBER

@interface MFWelcomPageController()<UIScrollViewDelegate>
{
    UIPageControl  *welcomePageControl;
}
///滚动的scrollView
@property(nonatomic, strong)UIScrollView *pageScrollView;
///显示的pageController
@property(nonatomic, strong)UIPageControl *welcomePageControl;
@property(nonatomic, assign)NSInteger      pageNumber;

@end
@implementation MFWelcomPageController
-(void)viewDidLoad
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //向数组中添加图片
    NSInteger height = (NSInteger)[UIScreen mainScreen].bounds.size.height;
    switch (height) {
        case 460:{
            
            self.welcomePageImages = @[@"4s1",@"4s2",@"4s3"];
            //4s的图
        }
            break;
        case 640:{
            //5s的图
            self.welcomePageImages = @[@"5s1",@"5s2",@"5s3"];
        }
            break;
        case 750:{
            //6s的图
            self.welcomePageImages = @[@"6s1",@"6s2",@"6s3"];
        }
            break;
        case 1080:{
            //6sp的图
            self.welcomePageImages = @[@"6sp1",@"6sp2",@"6sp3"];
        }
            break;
        default:{
            //=以后7的图有了再添加，先用6sp的图
            self.welcomePageImages =  @[@"6sp1",@"6sp2",@"6sp3"];
        }
            break;
    }
    
    [self addGuidenceView];
}
-(void)addGuidenceView
{
    
    UIScrollView *pageScrollView = [[UIScrollView  alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    pageScrollView.contentSize   = CGSizeMake(self.welcomePageImages.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    pageScrollView.delegate                       = self;
    pageScrollView.showsHorizontalScrollIndicator = NO;
    pageScrollView.showsVerticalScrollIndicator   = NO;
    pageScrollView.pagingEnabled                  = YES;
    pageScrollView.backgroundColor                = [UIColor whiteColor];
    [self.view addSubview:pageScrollView];
    self.pageScrollView                           = pageScrollView;
   
    [self addImageView];
    
    //跳过按钮
    UIImage   *jumpImage         = [UIImage imageNamed:@"跳--过@2x.png"];
    UIButton  *jumptoButton      = [UIButton buttonWithType:UIButtonTypeCustom];
    jumptoButton.frame           = CGRectMake(SCREEN_WIDTH - jumpImage.size.width - 10, 20, jumpImage.size.width, jumpImage.size.height);
    [jumptoButton setImage:jumpImage forState:UIControlStateNormal];
    [jumptoButton setImage:jumpImage forState:UIControlStateSelected];
    [jumptoButton addTarget:self action:@selector(jumptoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumptoButton];
    //pageControl
    welcomePageControl            = [[UIPageControl alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 30, [UIScreen mainScreen].bounds.size.width, 30)];
    welcomePageControl.numberOfPages              = self.welcomePageImages.count;
    welcomePageControl.currentPage                = 0;
    welcomePageControl.userInteractionEnabled     = NO;
    [self.view addSubview:welcomePageControl];
    self.welcomePageControl                       = welcomePageControl;
    
}
-(void)jumptoButtonAction:(UIButton *)button
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:NOTFISTOPEN ];
    [CommonUtils setRootViewControllerInLoginVC:NO];
}
-(void)addImageView
{
    self.pageNumber =  self.welcomePageImages.count;
    for (int imageCount = 0; imageCount < self.pageNumber; imageCount ++ ) {
      
        UIImageView  *pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageCount * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        pageImageView.image         = [UIImage imageNamed:self.welcomePageImages[imageCount]];
        [self.pageScrollView  addSubview:pageImageView];
        if (imageCount == self.pageNumber - 1) {
                //创建立即体验按钮
            UIImage   *gotoImage         = [UIImage imageNamed:@"立即进入@2x.png"];
            UIButton  *gotoButton      = [UIButton buttonWithType:UIButtonTypeCustom];
            gotoButton.frame           = CGRectMake(imageCount * [UIScreen mainScreen].bounds.size.width + ([UIScreen mainScreen].bounds.size.width - gotoImage.size.width)/2,SCREEN_HEIGHT/7 * 6,gotoImage.size.width,gotoImage.size.height );
            [gotoButton setImage:gotoImage forState:UIControlStateNormal];
            [gotoButton setImage:gotoImage forState:UIControlStateSelected];
            [gotoButton addTarget:self action:@selector(jumptoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.pageScrollView  addSubview:gotoButton];
        }
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float width = [UIScreen mainScreen].bounds.size.width;
    if (scrollView.contentOffset.x/width ==0) {
        welcomePageControl.currentPage                = 0;
    }else if (scrollView.contentOffset.x/width ==1){
        welcomePageControl.currentPage                = 1;
    }else{
        welcomePageControl.currentPage                = 2;
    }
}

@end
