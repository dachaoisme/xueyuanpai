//
//  BaseNavView.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/5.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "BaseNavView.h"
#import "AppDelegate.h"

@implementation BaseNavView

-(id)initWithTitle:(NSString *)title background:(NSString*)bgImage
{
    self = [super init];
    if (self) {
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints=NO;
        if(bgImage){
            UIImageView * bgImg=[UIFactory imageViewWithMode:UIViewContentModeScaleToFill image:bgImage];
            [self addSubview:bgImg];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bgImg]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bgImg)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bgImg]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bgImg)]];
        }
        
        float space = NAV_TOP_HEIGHT - 44;
        
        titLab = [[UILabel alloc] init];
        [titLab setFont:[UIFont systemFontOfSize:17]];
        [titLab setTextColor:[CommonUtils colorWithHex:@"333333"]];
        titLab.translatesAutoresizingMaskIntoConstraints=NO;
        [titLab setTextAlignment:NSTextAlignmentCenter];
        titLab.numberOfLines=1;
        [titLab setText:title];
        [self addSubview:titLab];
        
        UIView * line=[[UIView alloc] init];
        line.backgroundColor=LLColorLine;
        line.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:line];
        NSString * titlabConstraints = [NSString stringWithFormat:@"|-(%f)-[titLab]-(%f)-|",30.0,30.0];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:titlabConstraints options:0 metrics:nil views:NSDictionaryOfVariableBindings(titLab)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:titLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:space/2.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    }
    return self;
}
-(id)initWithTitle:(NSString *)title color:(NSString *)color
{
    self = [super init];
    if (self) {
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints=NO;
        if(color){
            self.backgroundColor=[CommonUtils colorWithHex:color];
        }
        
        float space=NAV_TOP_HEIGHT  - 44;
        
        titLab = [[UILabel alloc] init];
        [titLab setFont:[UIFont systemFontOfSize:17]];
        [titLab setTextColor:[CommonUtils colorWithHex:@"333333"]];
        titLab.translatesAutoresizingMaskIntoConstraints=NO;
        [titLab setTextAlignment:NSTextAlignmentCenter];
        titLab.numberOfLines=1;
        [titLab setText:title];
        [self addSubview:titLab];
        
        UIView * line=[[UIView alloc] init];
        line.backgroundColor=LLColorLine;
        line.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:line];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[titLab]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titLab)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:titLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:space/2.0]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.5)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    [titLab setText:title];
}

-(void)setCustomTitleSubLeftTitle:(NSString *)str1 color:(UIColor *)colorL SubRightTitle:(NSString*)str2 color:(UIColor *)colorR{
    
    NSString *string1 = str1;
    NSString *string2 = str2;
    NSString *title = [string1 stringByAppendingString:string2];
    NSRange r1 = [title rangeOfString:string1 options:NSCaseInsensitiveSearch];
    NSRange r2 = [title rangeOfString:string2 options:NSCaseInsensitiveSearch];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",title]];
    [str addAttribute:NSForegroundColorAttributeName value:colorL range:r1];
    [str addAttribute:NSForegroundColorAttributeName value:colorR range:r2];
    titLab.attributedText = str;
}

- (void)titleLabelHidden:(BOOL)hidden {
    titLab.hidden = hidden;
}

-(void)setTitleColor:(NSString *)color{
    [titLab setTextColor:[CommonUtils colorWithHex:color]];
}
-(void)setLeft:(NSString*)imageName{
    UIImage * image=[UIImage imageNamed:imageName];
    UIImageView *iv = [UIFactory imageViewWithMode:-1 image:imageName];
    [self addSubview:iv];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:backBtn];
    
    NSDictionary * views=NSDictionaryOfVariableBindings(iv,backBtn);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-16-[iv(%f)]",image.size.width/3] options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[backBtn(70)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[iv(%f)]",image.size.height/3] options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backBtn]|" options:0 metrics:nil views:views]];
}
-(void)setLeft
{
    UIImage * image=[UIImage imageNamed:@"d_go_back"];
    UIImageView *iv = [UIFactory imageViewWithMode:-1 image:nil];
    iv.image = image;
    [self addSubview:iv];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:backBtn];
    
    NSDictionary * views=NSDictionaryOfVariableBindings(iv,backBtn);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-16-[iv(%f)]",image.size.width] options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[backBtn(70)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[iv(%f)]",image.size.height] options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backBtn]|" options:0 metrics:nil views:views]];
}

-(void)setRightItem:(id)right target:(id)target selector:(SEL)selector{
    if (right) {
        if ([right isKindOfClass:[NSString class]]) {
            rightLab = [[UILabel alloc] init];
            [rightLab setFont:[UIFont systemFontOfSize:15.0]];
            [rightLab setTextColor:[CommonUtils colorWithHex:@"878d8f"]];
            rightLab.translatesAutoresizingMaskIntoConstraints=NO;
            [rightLab setTextAlignment:NSTextAlignmentRight];
            rightLab.numberOfLines=1;
            rightLab.text=(NSString*)right;
            [self addSubview:rightLab];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[rightLab]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightLab)]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        }else if ([right isKindOfClass:[UIImage class]]){
            [self tmpSetRightItem:right target:target selector:selector withScale:3];
        }
        
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.translatesAutoresizingMaskIntoConstraints=NO;
        [rightBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        NSDictionary * views=NSDictionaryOfVariableBindings(rightBtn);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[rightBtn(70)]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightBtn]|" options:0 metrics:nil views:views]];
    }
}
-(void)tmpSetRightItem:(id)right target:(id)target selector:(SEL)selector withScale:(NSInteger)scale {
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:right];
    iv.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:iv];
    
    badgeLab=[UIFactory label:20 color:@"ffffff" align:NSTextAlignmentCenter];
    badgeLab.backgroundColor=[CommonUtils colorWithHex:@"ff4861"];
    badgeLab.layer.cornerRadius=5;
    badgeLab.clipsToBounds=YES;
    badgeLab.hidden=YES;
    [self addSubview:badgeLab];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"[iv(%f)]-15-|",[(UIImage*)iv size].width/scale] options:0 metrics:nil views:NSDictionaryOfVariableBindings(iv)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeLab(10)]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeLab)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[iv(%f)]",[(UIImage*)iv size].height/scale] options:0 metrics:nil views:NSDictionaryOfVariableBindings(iv)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[badgeLab(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeLab)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:badgeLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:iv attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    
    if (scale == 2) {
        rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.translatesAutoresizingMaskIntoConstraints=NO;
        [rightBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        NSDictionary * views=NSDictionaryOfVariableBindings(rightBtn);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[rightBtn(70)]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightBtn]|" options:0 metrics:nil views:views]];
    }
}

-(void)setRithtTitle:(NSString *)title{
    if (rightLab) {
        [rightLab setText:title];
    }
}
-(void)setRightBadge:(int)number
{
    if (badgeLab) {
        //        badgeLab.hidden=NO;
        //        if (number>99) {
        //            badgeLab.font=[UIFont systemFontOfSize:PX_TO_PT(15)];
        //            badgeLab.text=@"99+";
        //            return;
        //        }else if (number>10){
        //            badgeLab.font=[UIFont systemFontOfSize:PX_TO_PT(21)];
        //        }else
        if (number>0){
            badgeLab.hidden=NO;
            
            //            badgeLab.font=[UIFont systemFontOfSize:PX_TO_PT(24)];
        }else{
            badgeLab.hidden=YES;
        }
        //        badgeLab.text=[NSString stringWithFormat:@"%d",number];
    }
}
-(void)setRightColor:(NSString *)color{
    if (rightLab && color) {
        [rightLab setTextColor:[CommonUtils colorWithHex:color]];
    }
}
-(void)onBtnClicked:(id)sender{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.navController popViewControllerAnimated:YES];
}

-(void)setBackTarget:(id)target selector:(SEL)selector{
    if (nil == backBtn){
        [self setLeft];
    }
    if (target && [target respondsToSelector:selector]) {
        [backBtn removeTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)clearBackgroundColor{
    [self setBackgroundColor:[UIColor clearColor]];
    NSArray* subviews = [self subviews];
    for(UIView* uv in subviews){
        [uv setBackgroundColor:[UIColor clearColor]];
    }
}
/**
 * 第一个参数事件target,第二个参数为控件资源,第三个参数为控件的tag,第三个参数为控件的tap事件...
 * 如果一个控件由图文组成,请传递图片名称,文字，图文的顺序以显示顺序为准,资源图片请以.png或者.jpg结尾，否则当文字处理
 * 调用此方法不能同时调用setRightButton相关的方法，否则此方法无准备。
 * eg.
 * [setRightWithObjectsAndSelectors:self,@"xx.png,选择",tag,@selector(sssss:),nil]
 */
-(void)setRightWithObjectsAndSelectors:(id)target, ...{
    if(nil == rightBtn){
        va_list args;
        va_start(args, target);
        if(nil != target){
            NSString* stringRes = va_arg(args, id);
            SEL selector = nil;
            int tag;
            if (nil != stringRes) { //有控件资源,初始化rightItems;
                rightItems = [[NSMutableDictionary alloc]initWithCapacity:1];
            }
            uint i = 1;
            uint j = 1;
            NSMutableString* strFMLItems = [[NSMutableString alloc]init];
            NSMutableDictionary* dicItems = [[NSMutableDictionary alloc]initWithCapacity:1];
            while ( nil!=stringRes ) {
                //处理资源
                NSArray* arrayRes = [stringRes componentsSeparatedByString:@","];
                UIButton* btn = [[UIButton alloc]init];
                [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
                NSMutableString* strFML = [[NSMutableString alloc]init];
                NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:1];
                [strFML appendString:@"|"];
                //构造buttonItem的子元素,以","分隔的字符串....
                for(NSString* res in arrayRes){
                    UIView* vw;
                    if ([[res lowercaseString] hasSuffix:@".png"] || [[res lowercaseString] hasSuffix:@".jpg"]){ //图片资源
                        UIImage* im = [UIImage imageNamed:res];
                        vw = [[UIImageView alloc]initWithImage:im];
                        [strFML appendFormat:@"-(%f)-[vw_%u(%f)]",PX_TO_PT(6.0),i,im.size.width/3];
                    }else{
                        vw = [[UILabel alloc]init];
                        [(UILabel*)vw setFont:[UIFont systemFontOfSize:15.0]];
                        [(UILabel*)vw setTextColor:[CommonUtils colorWithHex:@"ff4d73"]];
                        [(UILabel*)vw setTextAlignment:NSTextAlignmentCenter];
                        [(UILabel*)vw setNumberOfLines:1];
                        [(UILabel*)vw setText:res];
                        [strFML appendFormat:@"-(%f)-[vw_%u]",PX_TO_PT(6.0),i];
                    }
                    //构建子控件
                    [vw setTranslatesAutoresizingMaskIntoConstraints:NO];
                    [btn addSubview:vw];
                    [dic setObject:vw forKey: [NSString stringWithFormat:@"vw_%u",i]];
                    [rightItems setObject:vw forKey:[NSString stringWithFormat:@"%u",i]];
                    i++;
                }
                for (NSString* idx in dic ) {
                    if([dic[idx] isKindOfClass:[UIImageView class]]){
                        float h = ((UIImageView*)dic[idx]).image.size.height;
                        [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@(%f)]",idx,h/3] options:0 metrics:nil views:dic]];
                    }else{
                        [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@]",idx] options:0 metrics:nil views:dic]];
                    }
                }
                [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"%@|",strFML] options:0 metrics:nil views:dic]];
                //添加tag
                tag = va_arg(args, int);
                if(tag){
                    [btn setTag:tag];
                }
                //添加selector
                selector = va_arg(args, SEL);
                if(selector && [target respondsToSelector:selector]){
                    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
                }
                [self addSubview:btn];
                if(strFMLItems.length == 0){ //第一个不需要设置左边距,否则左边距离设置为119px
                    [strFMLItems appendFormat:@"[btn_%u]",j];
                }else{
                    [strFMLItems appendFormat:@"-(%f)-[btn_%u]",PX_TO_PT(119.0),j];
                }
                [dicItems setObject:btn forKey:[NSString stringWithFormat:@"btn_%u",j]];
                j++;
                stringRes = va_arg(args, id);
            }
            for (NSString* idx in dicItems ) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[%@]|",idx] options:0 metrics:nil views:dicItems]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:dicItems[idx] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            }
            for (NSString* idx in rightItems ) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:rightItems[idx] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            }
            //右边距离50px
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"%@-(%f)-|",strFMLItems,PX_TO_PT(50.0)] options:0 metrics:nil views:dicItems]];
            va_end(args);
        }
    }
}
-(void)setRightHidden:(BOOL)isHidden{
    if (rightLab) {
        rightLab.hidden = isHidden;
    }
}
/**
 *index是你传的资源从左到右的顺序的编号,最左边是1,依次是2,3,...
 *当你传的资源是以","分隔的多个资源组合时，其中的每一个资源也是从左至右依次编码的
 */
-(id)getRightObjectAtIndex:(uint)index{
    id object;
    if(rightItems){
        object = [rightItems objectForKey:[NSString stringWithFormat:@"%u",index]];
    }
    return object;
}

/**
 * 第一个参数事件target,第二个参数为控件资源,第三个参数为控件的tag,第三个参数为控件的tap事件...
 * 如果一个控件由图文组成,请传递图片名称,文字，图文的顺序以显示顺序为准,资源图片请以.png或者.jpg结尾，否则当文字处理
 * 调用此方法不能同时调用setRightButton相关的方法，否则此方法无准备。
 * eg.
 * [setRightWithObjectsAndSelectors:self,@"xx.png,选择",tag,@selector(sssss:),nil]
 */
-(void)setLeftWithObjectsAndSelectors:(id)target, ...{
    if(nil == backBtn){
        va_list args;
        va_start(args, target);
        if(nil != target){
            NSString* stringRes = va_arg(args, id);
            SEL selector = nil;
            int tag;
            if (nil != stringRes) { //有控件资源,初始化rightItems;
                leftItems = [[NSMutableDictionary alloc]initWithCapacity:1];
            }
            uint i = 1;
            uint j = 1;
            NSMutableString* strFMLItems = [[NSMutableString alloc]init];
            NSMutableDictionary* dicItems = [[NSMutableDictionary alloc]initWithCapacity:1];
            while ( nil!=stringRes ) {
                //处理资源
                NSArray* arrayRes = [stringRes componentsSeparatedByString:@","];
                UIButton* btn = [[UIButton alloc]init];
                [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
                NSMutableString* strFML = [[NSMutableString alloc]init];
                NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:1];
                [strFML appendString:@"|"];
                //构造buttonItem的子元素,以","分隔的字符串....
                for(NSString* res in arrayRes){
                    UIView* vw;
                    if ([[res lowercaseString] hasSuffix:@".png"] || [[res lowercaseString] hasSuffix:@".jpg"]){ //图片资源
                        UIImage* im = [UIImage imageNamed:res];
                        vw = [[UIImageView alloc]initWithImage:im];
                        [strFML appendFormat:@"-(%f)-[vw_%u(%f)]",PX_TO_PT(6.0),i,im.size.width/3];
                    }else{
                        vw = [[UILabel alloc]init];
                        [(UILabel*)vw setFont:[UIFont systemFontOfSize:15.0]];
                        [(UILabel*)vw setTextColor:[CommonUtils colorWithHex:@"878d8f"]];
                        [(UILabel*)vw setTextAlignment:NSTextAlignmentCenter];
                        [(UILabel*)vw setNumberOfLines:1];
                        [(UILabel*)vw setText:res];
                        [strFML appendFormat:@"-(%f)-[vw_%u]",PX_TO_PT(6.0),i];
                    }
                    //构建子控件
                    [vw setTranslatesAutoresizingMaskIntoConstraints:NO];
                    [btn addSubview:vw];
                    [dic setObject:vw forKey: [NSString stringWithFormat:@"vw_%u",i]];
                    [leftItems setObject:vw forKey:[NSString stringWithFormat:@"%u",i]];
                    i++;
                }
                for (NSString* idx in dic ) {
                    if([dic[idx] isKindOfClass:[UIImageView class]]){
                        float h = ((UIImageView*)dic[idx]).image.size.height;
                        [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@(%f)]",idx,h/3] options:0 metrics:nil views:dic]];
                    }else{
                        [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@]",idx] options:0 metrics:nil views:dic]];
                    }
                }
                [btn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"%@|",strFML] options:0 metrics:nil views:dic]];
                //添加tag
                tag = va_arg(args, int);
                if(tag){
                    [btn setTag:tag];
                }
                //添加selector
                selector = va_arg(args, SEL);
                if(selector && [target respondsToSelector:selector]){
                    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
                }
                [self addSubview:btn];
                if(strFMLItems.length == 0){ //第一个不需要设置左边距,否则左边距离设置为119px
                    [strFMLItems appendFormat:@"[btn_%u]",j];
                }else{
                    [strFMLItems appendFormat:@"-(%f)-[btn_%u]",PX_TO_PT(119.0),j];
                }
                [dicItems setObject:btn forKey:[NSString stringWithFormat:@"btn_%u",j]];
                j++;
                stringRes = va_arg(args, id);
            }
            for (NSString* idx in dicItems ) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[%@]|",idx] options:0 metrics:nil views:dicItems]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:dicItems[idx] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            }
            for (NSString* idx in leftItems ) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:leftItems[idx] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            }
            //右边距离50px
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-(%f)-%@",PX_TO_PT(50.0),strFMLItems] options:0 metrics:nil views:dicItems]];
            va_end(args);
        }
    }
}

/**
 *index是你传的资源从左到右的顺序的编号,最左边是1,依次是2,3,...
 *当你传的资源是以","分隔的多个资源组合时，其中的每一个资源也是从左至右依次编码的
 */
-(id)getLeftObjectAtIndex:(uint)index{
    id object;
    if(leftItems){
        object = [leftItems objectForKey:[NSString stringWithFormat:@"%u",index]];
    }
    return object;
}

#pragma mark -  收件箱中，导航栏包括两个标签，分别是广播和私信页
/*
 *收件箱中，导航栏包括两个标签，分别是广播和私信页
 *
 *
 */
-(id)initInboxNavigationBarWithcolor:(NSString *)color withIsBroadcast:(BOOL)isBroadcast
{
    self = [super init];
    if (self) {
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints=NO;
        if(color){
            self.backgroundColor=[CommonUtils colorWithHex:color];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v_inbox_bg_bar"]];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        
        broadcastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        broadcastBtn.translatesAutoresizingMaskIntoConstraints = NO;
        broadcastBtn.tag = 10001;
        broadcastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:48.0/3];
        [broadcastBtn setTitleColor:[CommonUtils colorWithHex:@"ff4861"] forState:UIControlStateNormal];
        [broadcastBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [broadcastBtn setBackgroundImage:[UIImage imageNamed:@"v_inbox_left_bar"] forState:UIControlStateSelected];
        [broadcastBtn setTitle:@"广播" forState:UIControlStateNormal];
        [broadcastBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:broadcastBtn];
        
        chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chatBtn.translatesAutoresizingMaskIntoConstraints = NO;
        chatBtn.tag = 10002;
        chatBtn.titleLabel.font = [UIFont boldSystemFontOfSize:48.0/3];
        [chatBtn setTitleColor:[CommonUtils colorWithHex:@"ff4861"] forState:UIControlStateNormal];
        [chatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [chatBtn setBackgroundImage:[UIImage imageNamed:@"v_inbox_right_bar"] forState:UIControlStateSelected];
        [chatBtn setTitle:@"私信" forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chatBtn];
        
        if (isBroadcast == YES) {//说明默认选中的是广播
            broadcastBtn.selected = YES;
            chatBtn.selected = NO;
        }else{//说明默认选中的是私信
            chatBtn.selected = YES;
            broadcastBtn.selected = NO;
        }
        
        UIView * line=[[UIView alloc] init];
        line.backgroundColor=[CommonUtils colorWithHex:@"c6c6c6"];
        line.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:line];
        
        float width = 85;
        float spaceWidth = (SCREEN_WIDTH-width * 2)/2;
        //横向约束
        NSString * imageViewString = [NSString stringWithFormat:@"|-(%f)-[imageView(%f)]-(%f)-|",spaceWidth-0.5,width*2+1,spaceWidth-0.5];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:imageViewString options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
        NSString * broadcastString = [NSString stringWithFormat:@"|-(%f)-[broadcastBtn(%f)]-(%f)-|",spaceWidth,width,spaceWidth+width];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:broadcastString options:0 metrics:nil views:NSDictionaryOfVariableBindings(broadcastBtn)]];
        NSString * chatString = [NSString stringWithFormat:@"|-(%f)-[chatBtn(%f)]-(%f)-|",width + spaceWidth,width,spaceWidth];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:chatString options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
        //纵向约束
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(28.5)-[imageView(27)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(29)-[broadcastBtn(26)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(broadcastBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(29)-[chatBtn(26)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chatBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(63)-[line(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
        
        UIView * chatCircleView = [[UIView alloc]initWithFrame:CGRectMake(width-20, 2, 8, 8)];
        chatCircleView.backgroundColor = [CommonUtils colorWithHex:@"fc4b64"];
        chatCircleView.layer.cornerRadius = 4.0;
        chatCircleView.clipsToBounds = YES;
        [chatBtn addSubview:chatCircleView];
        
    }
    return self;
}
//设置返回按钮
-(void)setInboxLeft
{
    UIImage * image=[UIImage imageNamed:@"d_go_back"];
    UIImageView *iv = [UIFactory imageViewWithMode:-1 image:nil];
    iv.image = image;
    [self addSubview:iv];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:backBtn];
    
    NSDictionary * views=NSDictionaryOfVariableBindings(iv,backBtn);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-16-[iv(%f)]",image.size.width] options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[backBtn(70)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[iv(%f)]",image.size.height] options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:broadcastBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backBtn]|" options:0 metrics:nil views:views]];
}

-(void)clickAction:(UIButton *)sender
{
    if (sender.tag == 10001) {
        //广播
        sender.selected = YES;
        chatBtn.selected = NO;
        if ([self.delegate respondsToSelector:@selector(isSelectedBroadcastWithBool:)]) {
            [self.delegate isSelectedBroadcastWithBool:YES];
        }
        
    }else{
        //私信
        sender.selected = YES;
        broadcastBtn.selected = NO;
        if ([self.delegate respondsToSelector:@selector(isSelectedBroadcastWithBool:)]) {
            [self.delegate isSelectedBroadcastWithBool:NO];
        }
    }
}
#pragma mark - 新添加

-(void)setUserDefinedLeftBtnWithImage:(NSString *)imageName withTarget:(id)target selected:(SEL)selected
{
    UIImage * image=[UIImage imageNamed:imageName];
    UIImageView *iv = [UIFactory imageViewWithMode:-1 image:imageName];
    [self addSubview:iv];
    
    userDefinedLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userDefinedLeftBtn addTarget:target action:selected forControlEvents:UIControlEventTouchUpInside];
    userDefinedLeftBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:userDefinedLeftBtn];
    
    NSDictionary * views=NSDictionaryOfVariableBindings(iv,userDefinedLeftBtn);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-16-[iv(%f)]",image.size.width/3] options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[userDefinedLeftBtn(70)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[iv(%f)]",image.size.height/3] options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:titLab attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[userDefinedLeftBtn]|" options:0 metrics:nil views:views]];
}
-(void)setUserDefinedLeftBtnWithTitle:(NSString *)title withTarget:(id)target selected:(SEL)selected;
{
    userDefinedLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [userDefinedLeftBtn setTitle:title forState:UIControlStateNormal];
    [userDefinedLeftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [userDefinedLeftBtn setFrame:CGRectMake(16, 0, 64, 44)];
    [userDefinedLeftBtn addTarget:target action:selected forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:userDefinedLeftBtn];
    
}

-(void)setUserDefineLeftReturnBtn
{
    UIButton * button = [UIFactory button:nil sel:nil titleColor:@"" title:@"返回" fontSize:17 frame:CGRectMake(16, 0, 64, 44)];
    [button addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
-(void)onBackBtnClicked:(id)sender{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.navController popViewControllerAnimated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
