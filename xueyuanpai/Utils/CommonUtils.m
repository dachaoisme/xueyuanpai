//
//  CommonUtils.m
//  MFTour
//
//  Created by lidachao on 15/12/3.
//  Copyright © 2015年 lidachao. All rights reserved.
//

#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIView+Toast.h"
#import "sys/xattr.h"
@implementation CommonUtils

+(BOOL)checkIsNum:(NSString *)str{
//    NSString *num = @"^[0-9]+\\.{0,1}[0-9]{0,2}$";
    NSString *num = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    return res;
}

+(BOOL)checkIsWorld:(NSString *)str{
    NSString *num = @"^[a-z]+$";//@"^[A-Za-z]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    return res;
}

+(BOOL)checkIsWorldAndNum:(NSString *)str{
    NSString *num = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_]+$";//@"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";//@"^[0-9]+\\.{0,1}[0-9]{0,2}$^[a-z]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL res = [regExPredicate evaluateWithObject:str];
    
    return res;
}

+(BOOL)checkIsEmail:(NSString*)str{
    BOOL ret=NO;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    ret = [emailTest evaluateWithObject:str];
    return ret;
}

+ (NSString *)base64:(NSString*)abc
{
    // Create NSData object
    NSData *nsdata = [abc dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    return base64Encoded;
}

+ (NSString *)URLEncodedString:(NSString*)url
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    NSLog(@"encodedString:%@", encodedString);
    return encodedString;
}

+ (NSString*)md5:(NSString *)string
{
    const char * original_str = [string UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (CC_LONG)strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5, 大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}

+ (NSString *)getNoneEmptyStringWithString:(NSString *)string
{
    return (string==nil?@"":string);
}

+(void)addChildInRootView:(id)child{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.navBar.view addSubview:child];
}
#pragma mark - 先注释掉
//+(NSInteger)getNetWorkStatus
//{
//    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
//}

+ (UIColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*)colorWithHex:(NSString *)hexValue{
    char *stopstring;
    long hex = strtol([hexValue cStringUsingEncoding:NSUTF8StringEncoding], &stopstring, 16);
    int r, g, b;
    r = ( 0xff <<16 & hex ) >> 16;
    g = ( 0xff <<8 & hex ) >> 8;
    b = 0xff & hex;
    return [UIColor colorWithRed:(0.0f + r)/255 green:(0.0f + g)/255 blue:(0.0f + b)/255 alpha:1.0];
}

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage*)sourceImage
{
    if (!sourceImage) {
        return nil;
    }
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, YES, 1.0);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

+(NSString*) getRNToken:(const char* ) buffer length:(int)buf_len {
    char hexchar[] = "0123456789ABCDEF";
    size_t i;
    char *p;
    int len = (buf_len * 2) + 1;
    p = malloc(len);
    for (i = 0; i < buf_len; i++) {
        p[i * 2] = hexchar[(unsigned char)buffer[i] >> 4 & 0xf];
        p[i * 2 + 1] = hexchar[((unsigned char)buffer[i] ) & 0xf];
    }
    p[i * 2] = '\0';
    NSString * result = [NSString stringWithCString:p encoding:NSUTF8StringEncoding];
    free(p);
    return result;
}

+ (BOOL) isChildWithBirthday:(NSString *)birthday travelDay:(NSString*)travelDay
{
    NSInteger birthYear=[[birthday substringToIndex:4] integerValue];
    birthYear+=12;
    NSString *adultDay=[NSString stringWithFormat:@"%ld%@",(long)birthYear,[birthday substringFromIndex:4]];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *adultDate=[dateFormatter dateFromString:adultDay];
    NSDate *travelDate=[NSDate date];
    if (travelDay && travelDay.length>0) {
        travelDate=[dateFormatter dateFromString:travelDay];
    }
    NSLog(@"adultDate = %@ travelDate = %@",adultDate,travelDate);
    return [adultDate compare:travelDate]>0;
}

+ (BOOL) validateIdentityCard: (NSString *)cardNo
{
    /*
    if ([cardNo length] != 18) {
        return NO;
    }
    NSString *carid = cardNo;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6, 4)] intValue];
    
    //月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10, 2)] intValue];
    
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12, 2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    char *PaperId  = (char*)[carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    
    //校验数字
    for (int i=0; i<18; i++){
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ){
            return NO;
        }
        if (i==17 && PaperId[i]=='x') {
            PaperId[i]='X';
        }
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++){
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] ){
        return NO;
    }
    return YES;
     */
    
    NSString *value = cardNo;
    
        value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([value length] != 18) {
            return NO;
            }
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if (![regexTest evaluateWithObject:value]) {
                     return NO;
                 }
        int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
                     + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
                    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
                     + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
                     + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
            + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
                    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
                     + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
                     + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
        NSInteger remainder = summary % 11;
        NSString *checkBit = @"";
        NSString *checkString = @"10X98765432";
        checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
        return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
}

+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextheight:(CGFloat)textheight
{
    //Lable自动换行并且自适应
    // 列高
    CGFloat contentHeight = textheight;
    // 用何種字體進行顯示
    UIFont *font         = [UIFont systemFontOfSize:fontSize];
    // 該行要顯示的內容
    NSString *content    = text;
    // 計算出顯示完內容需要的最小尺寸
    /*
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
     CGSize size = [content boundingRectWithSize:CGSizeMake(288, 134) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
     */
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-120, contentHeight)  options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
}
+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextWidth:(CGFloat)textWidth
{
    //Lable自动换行并且自适应
    // 列宽度
    CGFloat contentWidth = textWidth;
    // 用何種字體進行顯示
    UIFont *font         = [UIFont systemFontOfSize:fontSize];
    // 該行要顯示的內容
    NSString *content    = text;
    // 計算出顯示完內容需要的最小尺寸
    /*
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
     paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
     NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
     CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 1334) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
     
     */
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 10000)  options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    CGSize endSize = CGSizeMake(size.width, size.height);
    return endSize;
}

+ (void)callServiceWithTelephoneNum:(NSString *)telephoneNum
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",telephoneNum]];
    [[UIApplication sharedApplication] openURL:phoneURL];

}

/*
 -1:已取消0:未支付 1:已支付 2:联票检票中3:已检票 4:已结算，5:已结算已支付8：请求退款9：已退票10：过期票
 */
+ (NSString *)getOrderState:(int )orderState {
    
    NSString *state = @"";
    
    switch (orderState) {
        case -1:
            state = @"已取消";
            break;
        case 0:
            state = @"未支付";
            break;
        case 1:
            state = @"已支付";
            break;
        case 2:
            state = @"部分已检";
            break;
        case 3:
            state = @"已检票";
            break;
        case 4:
            state = @"已结算";
            break;
        case 5:
            state = @"已结算已支付";
            break;
        case 8:
            state = @"请求退款";
            break;
        case 9:
            state = @"已退票";
            break;
        case 10:
            state = @"过期票";
            break;
    }
    return state;
}
/*
 Success = 10000,
 ParamMistake = 10001,
 UserNameOrPasswordMistake = 10002,
 ServerAbnormal = 10003,
 TokenInvalid = 10004,
 OldPassWordMistake = 10005,
 UpdateMessageMistake = 10006,
 UpLoadFileMistake = 10007,
 SignMistake = 10008
 */
+ (NSString *)codeState:(int)code {
    NSString *state = @"";
    switch (code) {
        case Success:
            return @"成功";
            break;
        case ParamMistake:
            return @"参数错误";
            break;
        case UserNameOrPasswordMistake:
            return @"用户名或密码错误";
            break;
        case ServerAbnormal:
            return @"服务器异常";
            break;
        case TokenInvalid:
            return @"token失效请登录";
            break;
        case OldPassWordMistake:
            return @"旧密码错误";
            break;
        case UpdateMessageMistake:
            return @"修改信息失败";
            break;
        case UpLoadFileIsEmpty:
            return @"上传文件为空";
            break;
        case SignMistake:
            return @"验签失败";
            break;
    }
    return state;
}
#pragma mark - 暂时先注释掉
//+(void)setRootViewControllerInLoginVC:(BOOL)isLogin
//{
//    AppDelegate * appDelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
//    [appDelegate setRootViewController:isLogin];
//}

+(void)showToastWithStr:(NSString *)toastStr
{
    [[UIApplication sharedApplication].keyWindow makeToast:toastStr duration:2.0 position:CSToastPositionCenter];
}

+(void)showToastWithStr:(NSString *)toastStr WithTime:(NSTimeInterval )duration
{
    [[UIApplication sharedApplication].keyWindow makeToast:toastStr duration:duration position:CSToastPositionCenter];
}
+(void)hideAllToast
{
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}
+ (NSArray *)reverseBackProvince
{

    //获取到存储本地的字典
    NSString *filePath         = [[NSBundle mainBundle] pathForResource:@"cityOfIndex" ofType:@"plist"];
    NSDictionary *cityOfIndex  = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *indexArray        = [cityOfIndex.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSMutableArray * soureArray = [[NSMutableArray alloc] init];
    for (NSString * key in indexArray) {
        NSArray * cityOfIndexArray = [cityOfIndex objectForKey:key];
        for (NSString * city in cityOfIndexArray) {
            [soureArray addObject:city];
        }
    }
    
    NSArray * resultArray = [[NSArray alloc] initWithArray:soureArray];
    
    return resultArray;
    
}

+(NSMutableAttributedString *)lineStr:(NSString *)str
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName: [CommonUtils colorWithHex:@"999999"]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
    
    return attribtStr;
}

//计算是周几
+(NSString *)changedStringToWeak:(NSString *)timestamp
{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger weekday = [components weekday];
    
    NSString *weakString = @"";
    switch (weekday) {
        case 1:{
            weakString = @"周日";
        }
            
            break;
        case 2:{
            weakString = @"周一";
        }
            
            break;
        case 3:{
            weakString = @"周二";
        }
            
            break;
        case 4:{
            weakString = @"周三";
        }
            
            break;
        case 5:{
            weakString = @"周四";
        }
            
            break;
        case 6:{
            weakString = @"周五";
        }
            
            break;
        case 7:{
            weakString = @"周六";
        }
            
            break;
        default:
            break;
    }
    
    return weakString;
    
}
//返回年-月-日样式的时间
+ (NSString *)yearMonthDayWithString:(NSString *)time
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init] ;
    NSTimeZone *timeZone        = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//返回年-月-日-时-分-秒样式的时间
+ (NSString *)yearMontrhDayHourMinatueScend:(NSString *)time
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init] ;
    NSTimeZone *timeZone        = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(NSString *)getCurrenttime
{
    
    NSDate *currentDate           =[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime   =[dateformatter stringFromDate:currentDate];
    
    return currentTime;
}


+(NSString *)getTimeSinceNowWithLaterDays:(NSString *)days
{
    
    NSDate *date  =[[NSDate alloc] initWithTimeIntervalSinceNow:60*60*24*[days integerValue]];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time   =[dateformatter stringFromDate:date];
    
    return time;
}

/**
 BALANCE("BALANCE","余额"),
	KQ("KQ","块钱"),
	KQWAP("KQWAP","块钱WAP"),
	ALIPAY("ALIPAY","支付宝"),
	ALIPAYWAP("ALIPAYWAP","支付宝 WAP"),
	ALIPAYMOBILE("ALIPAYMOBILE","支付宝 WAP"),
	WECHATJSAPI("WECHATJSAPI","微信JSAPI"),
	WEIXIN("WEIXIN","微信"),
	WECHATNATIVE("WECHATNATIVE","微信原生态");
 */


+(double)getValueFromString:(NSString *)str
{
    NSString * tempStr = [NSString stringWithFormat:@"$%@",str];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencyCode = @"USD";
    double value = [[formatter numberFromString: tempStr] doubleValue];
    
    NSLog(@"%f",value);
    
    return value;
}
+(NSString *)notRounding:(float)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+(BOOL)checkFileExistByName:(NSString *)name{
    return [[NSFileManager defaultManager] fileExistsAtPath:[CommonUtils dataFilePathWithName:name]];
}
+(NSString *) dataFilePathWithName:(NSString *)name {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    //在Documents下面再包一个文件夹，便于删除图片缓存 @libin
    BOOL isDir;
    NSString *imageDir = [NSString stringWithFormat:@"%@/%@",documentsDir,@"lezyo_image"];
    BOOL existed = ([[NSFileManager defaultManager] fileExistsAtPath:imageDir isDirectory:&isDir] && isDir);
    if (!existed) {
        [[NSFileManager defaultManager] createDirectoryAtPath:imageDir withIntermediateDirectories:YES
                                                   attributes:nil error:nil];
        
    }
    [self addSkipBackupAttributeToPath:imageDir];
    //原来只以documentDir作为目录，现在以lezyo_image作为目录
    NSString *fpath = [[NSString alloc] initWithFormat:@"%@",[imageDir stringByAppendingPathComponent:name]];
    return fpath;
}

#pragma mark - 存储到icloud里面的内容均不需要存储到icloud内
+ (void)addSkipBackupAttributeToPath:(NSString*)path {
    u_int8_t b = 1;
    setxattr([path fileSystemRepresentation], "com.apple.MobileBackup", &b, 1, 0, 0);
}

+(NSString *)getEffectiveUrlWithUrl:(NSString *)url
{
    NSString *effectiveUrl = [NSString stringWithFormat:@"%@%@",baseBackgroundUrl,url];
    return effectiveUrl;
}
@end


