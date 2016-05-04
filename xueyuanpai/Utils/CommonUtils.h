//
//  CommonUtils.h
//  MFTour
//
//  Created by lidachao on 15/12/3.
//  Copyright © 2015年 lidachao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject
/**
 *  @brief  正则表达式验证字符串是否由数字组成
 *
 *  @param  str 传入字符串
 *
 *  @return
 */
+(BOOL)checkIsNum:(NSString *)str;

/**
 *  @brief  正则表达式验证字符串是否由字母组成
 *
 *  @param  str 传入字符串
 *
 *  @return
 */
+(BOOL)checkIsWorld:(NSString *)str;

/**
 *  @brief  正则表达式验证字符串是否由数字或字母组成
 *
 *  @param  str 传入字符串
 *
 *  @return
 */
+(BOOL)checkIsWorldAndNum:(NSString *)str;

/**
 *  @brief  验证邮箱格式
 *
 *  @param  str 传入字符串
 *
 *  @return
 */
+(BOOL)checkIsEmail:(NSString*)str;

/**
 *  @brief  base64加密
 *
 *  @param  string 传入字符串
 *
 *  @return
 */
+ (NSString *)base64:(NSString*)string;

/**
 *  @brief  md5加密
 *
 *  @param  string 传入字符串
 *
 *  @return
 */
+ (NSString *)md5:(NSString *)string;

/**
 *  @brief  URLEncoded编码
 *
 *  @param  url 传入字符串
 *
 *  @return
 */
+ (NSString *)URLEncodedString:(NSString*)url;

/**
 *  @brief  避免获取空字符串
 *
 *  @param  string 传入字符串
 *
 *  @return
 */
+ (NSString *)getNoneEmptyStringWithString:(NSString *)string;

/**
 *  @brief  计算字符串长度
 *
 *  @param  text 传入字符串
 *
 *  @return
 */
+ (int)textLength:(NSString *)text;

/**
 *  @brief  显示toast
 *
 *  @param  child 需要展示的视图
 *
 *  @return
 */
+(void)addChildInRootView:(id)child;

/**
 *  @brief  获取网络状态
 *
 *  @param  url 传入字符串
 *
 *  @return NetworkStatus  网络状态
 */
+ (NSInteger)getNetWorkStatus;

/**
 *  @brief  根据16进制字符串获取颜色值，能调节透明度
 *
 *  @param  hexValue 传入的16进制数
 *  
 *  @param  alphaValue 透明度
 *
 *  @return  
 */
+ (UIColor*)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;

/**
 *  @brief  根据16进制字符串获取颜色值
 *
 *  @param  hexValue 传入的16进制数
 *
 *  @return
 */
+ (UIColor*)colorWithHex:(NSString *)hexValue;

/**
 *  @brief  压缩图片到指定大小
 *
 *  @param  targetSize 压缩后的大小
 *
 *  @param  sourceImage 需要压缩的图片
 *
 *  @return
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage*)sourceImage;

/**
 *  @brief  缩放uiimage
 *
 *  @param  size 缩放后的大小
 *
 *  @param  img 需要缩放的图片
 *
 *  @return
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 *  @brief  图片截取方法
 *
 *  @param  rect 需要截取的位置和大小
 *
 *  @param  imageToCrop 需要截取的图片
 *
 *  @return
 */
+(UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect;

/**
 *  @brief  将推送token转换成字符串
 *
 *  @param  buffer token串
 *
 *  @param  buf_len token串的长度
 *
 *  @return
 */
+(NSString*) getRNToken:(const char* ) buffer length:(int)buf_len;

/**
 *  @brief  身份号是否合法
 *
 *  @param  cardNo 身份证号
 *
 *  @return
 */
+ (BOOL) validateIdentityCard: (NSString *)cardNo;

/**
 *  @brief  是否位成人
 *
 *  @param  cardNo 身份证号
 *
 *  @return
 */
+ (BOOL) isChildWithBirthday:(NSString *)birthday travelDay:(NSString*)travelDay;

/**
 *  @brief  传入身份证号，返回生日
 *
 *  @param  numberStr 身份证号
 *
 *  @return
 */
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;

/**
 *  @brief  根据高度，去计算文本的宽度
 *
 *  @param  text  字符串
 *
 *  @param  fontSize 字体大小
 *
 *  @param  textheight 文字的高度
 *
 *  @return
 */
+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextheight:(CGFloat)textheight;

/**
 *  @brief  根据宽度，去计算文本的高度
 *
 *  @param  text  字符串
 *
 *  @param  fontSize 字体大小
 *
 *  @param  textWidth 文字的宽度
 *
 *  @return
 */
+(CGSize )getTextSizeWithText:(NSString *)text WithFont:(CGFloat)fontSize WithTextWidth:(CGFloat)textWidth;

/**
 *  @brief  根据号码，拨打电话
 *
 *  @param  telephoneNum  手机号
 *
 *  @return
 */
+ (void)callServiceWithTelephoneNum:(NSString *)telephoneNum;

/**
 *  @brief  -1:已取消0:未支付 1:已支付 2:联票检票中3:已检票 4:已结算，5:已结算已支付8：请求退款9：已退票10：过期票
 *
 *  @param  orderState  订单返回码
 *
 *  @return
 */
+ (NSString *)getOrderState:(int )orderState;

/**
 *  @brief  服务器返回状态码
 *
 *  @param  code  服务器返回码
 *
 *  @return
 */
+ (NSString *)codeState:(int)code;

/**
 *  @brief  切换根视图
 *
 *  @param  isLogin  是否登录成功
 *
 *  @return
 */
+(void)setRootViewControllerInLoginVC:(BOOL)isLogin;
/**
 *  @brief  展示提示语
 *
 *  @param  toastStr  提示语
 *
 *  @return
 */
+(void)showToastWithStr:(NSString *)toastStr;
/**
 *  @brief  展示提示语
 *
 *  @param  toastStr  提示语
 *
 *  @return
 */
+(void)showToastWithStr:(NSString *)toastStr WithTime:(NSTimeInterval )duration;
/**
 *  @brief  取消提示语
 *
 *  @param  toastStr  提示语
 *
 *  @return
 */
+(void)hideAllToast;
/**
 *  @brief 返回省份列表
 *
 *  @param
 *
 *  @return  返回值为一个按首字母排好序的一维数组
 */
+ (NSArray *)reverseBackProvince;
/**
 *  @brief 返回有中划线的字符串
 *
 *  @param
 *
 *  @return  返回值为一个按首字母排好序的一维数组
 */
+(NSMutableAttributedString *)lineStr:(NSString *)str;
/**
 *  @brief 返回给定日期是星期几
 *
 *  @param
 *
 *  @return 返回值为“周一、周二、周三、周四、周五、周六、周日”
 */
+(NSString *)changedStringToWeak:(NSString *)timestamp;
/**
 *  @brief 返回年-月-日
 *
 *  @param
 *
 *  @return 返回值为“2015-12-24”
 */
+ (NSString *)yearMonthDayWithString:(NSString *)time;
/**
 *  @brief 返回年-月-日-时-分-秒
 *
 *  @param
 *
 *  @return 返回值为“2015-12-24 15:21:50”
 */
+ (NSString *)yearMontrhDayHourMinatueScend:(NSString *)time;
/**
 *  @brief 返回年-月-日
 *
 *  @param
 *
 *  @return 返回值为“2015-12-24”
 */
+(NSString *)getCurrenttime;
/**
 *  @brief  返回年-月-日
 *
 *  @param  days表示获取的时间是今天以后的几天
 *
 *  @return 返回值为“2015-12-24”
 */
+(NSString *)getTimeSinceNowWithLaterDays:(NSString *)days;
/**
 *  @brief  从字符串里面获取整数数值后者小数数值
 *
 *  @param  str 字符串里面是数字
 *
 *  @return 返回200.3 、200  0.3
 */
+(double)getValueFromString:(NSString *)str;
/**
 *  @brief  浮点型float数据，四舍五入
 *
 *  @param  price 数字
 *
 *  @return 返回字符串200.3 、200  0.3
 */
+(NSString *)notRounding:(float)price afterPoint:(int)position;
@end
