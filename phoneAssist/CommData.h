//
//  CommData.h
//  alarm
//
//  Created by zhuang chaoxiao on 15-6-15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#ifndef alarm_CommData_h
#define alarm_CommData_h


////////////////////////////////////////////////////////////////////////////////////

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define TAB_WIDTH   SCREEN_WIDTH
#define TAB_HEIGHT  50
#define TAB_NUM   4

#define TAB_ICON_W 30
#define TAB_ICON_H 30



#define RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f)  blue:(b/255.0f) alpha:(1)]
#define COMMON_BG_COLOR  RGB(10,10,10)

#define COLOR_FROM_HEX(hexValue) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0])


#define BAIDU_APP_ID @"edf2086c"
#define BAIDU_ADV_ID  @"2066679"

#define UM_SHARE_KEY  @"561b5f8067e58e0a5800061b"

////
#define SHOW_APP_YEAR  2015
#define SHOW_APP_MONTH 11
#define SHOW_APP_DAY   20

#define DataCounterKeyWWANSent @"WWANSent"
#define DataCounterKeyWWANReceived   @"WWANReceived"
#define DataCounterKeyWiFiSent   @"WiFiSent"
#define DataCounterKeyWiFiReceived   @"WiFiReceived"


#define kNumberOfDaysUntilShowAgain 3
#define kAppStoreAddress @"https://itunes.apple.com/us/app/xy-shou-ji-zhu-shou-mian-fei/id1048451512?l=zh&ls=1&mt=8"
#define kAppName @"'XY手机助手'"


#define SHARE_TEXT @"我的网速打败了全国98%的用户，你的呢？  https://itunes.apple.com/us/app/xy-shou-ji-zhu-shou-mian-fei/id1048451512?l=zh&ls=1&mt=8"
#define SHARE_URL  @"https://itunes.apple.com/us/app/xy-shou-ji-zhu-shou-mian-fei/id1048451512?l=zh&ls=1&mt=8"
#define SHARE_IMAGE  ([UIImage imageNamed:@"58"])

//////////////////////////////////////////////

#define ADV_BUYED  @"ADV_BUYED"


#define STORE_RATE_FLAG  @"STORE_RATE_FLAG" //在清理的时候 点击好评

#define STORE_CHARGE_COUNT  @"STORE_CHARGE_COUNT"//充电次数
#define STORE_NET_INFO  @"STORE_NET_INFO"
#define STORE_SIGN_INFO  @"STORE_SIGN_INFO"
//
#define STORE_NET_CLEAN_DATE @"STORE_NET_CLEAN_DATE"
#define STORE_STORAGE_CLEAN_DATE  @"STORE_STORAGE_CLEAN_DATE"
#define STORE_BATTERY_CLEAN_DATE   @"STORE_BATTERY_CLEAN_DATE"

//
#define NET_CLEAN_KEEP       (3600*24*5)
#define STORAGE_CLEAN_KEEP   (3600*24*2)
#define BATTERY_CLEAR_KEEP   (3600*24*4)



#endif
