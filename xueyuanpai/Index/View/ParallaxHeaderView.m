//
//  ParallaxHeaderView.m
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <QuartzCore/QuartzCore.h>

#import "ParallaxHeaderView.h"
#import "UIImageView+WebCache.h"

@interface ParallaxHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (nonatomic) IBOutlet UIImageView *bluredImageView;
@end

//self.frame.size.width self.frame.size.height/2
#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)

static CGFloat kParallaxDeltaFactor = 0.5f;
static CGFloat kMaxTitleAlphaOffset = 100.0f;

@implementation ParallaxHeaderView

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    headerView.headerImage = image;
    [headerView initialSetupForDefaultHeader];
    return headerView;
    
}

+ (id)parallaxHeaderViewWithImageurl:(NSURL *)imageurl forSize:(CGSize)headerSize
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    [headerView initialSetupForDefaultHeader];
    headerView.URL = imageurl;
    
    return headerView;
}

+ (id)parallaxHeaderViewWithSubView:(UIView *)subView
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height)];
    [headerView initialSetupForCustomSubView:subView];
    return headerView;
}

- (void)awakeFromNib
{
    if (self.subView)
        [self initialSetupForCustomSubView:self.subView];
    else
        [self initialSetupForDefaultHeader];
    
    [self refreshBlurViewForNewImage];
}


- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    CGRect frame = self.imageScrollView.frame;
    
    if (offset.y > 0)
    {
        //上划色值的改变
        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        self.imageScrollView.frame = frame;
        self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y;
        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.clipsToBounds = NO;
        self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset;
    }
}

- (void)refreshBlurViewForNewImage
{
    UIImage *screenShot = [self screenShotOfView:self];
//    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

#pragma mark -
#pragma mark Private

- (void)initialSetupForDefaultHeader
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView = scrollView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = self.headerImage;
    self.imageView = imageView;
    [self.imageScrollView addSubview:imageView];
     
     
    self.bluredImageView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    self.bluredImageView.autoresizingMask = self.imageView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self.imageScrollView addSubview:self.bluredImageView];
    
    [self addSubview:self.imageScrollView];
    
    [self refreshBlurViewForNewImage];
}

- (void)initialSetupForCustomSubView:(UIView *)subView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView = scrollView;
    self.subView = subView;
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.imageScrollView addSubview:subView];
    
    self.bluredImageView = [[UIImageView alloc] initWithFrame:subView.frame];
    self.bluredImageView.autoresizingMask = subView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self.imageScrollView addSubview:self.bluredImageView];
    
    [self addSubview:self.imageScrollView];
    [self refreshBlurViewForNewImage];
}

- (void)setHeaderImage:(UIImage *)headerImage
{
    _headerImage = headerImage;
    self.imageView.image = headerImage;
    [self refreshBlurViewForNewImage];
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    [self.imageView setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"defaultdetial2.png"]];
    [self refreshBlurViewForNewImage];
}

- (UIImage *)screenShotOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(kDefaultHeaderFrame.size, YES, 0.0f);
    [self drawViewHierarchyInRect:kDefaultHeaderFrame afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
