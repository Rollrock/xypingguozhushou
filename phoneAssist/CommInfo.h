//
//  CommInfo.h
//  NewiPhoneADV
//
//  Created by zhuang chaoxiao on 15/8/13.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaiduMobAdView.h"

@interface CommInfo : NSObject

@end


@interface NetUseInfo : NSObject<NSCoding>
@property(assign) NSInteger lastByte;
@property(strong) NSDate * lastDate;
@end


@interface SignInfo : NSObject<NSCoding>
@property(assign) NSInteger score;
@property(strong) NSDate * lastDate;
@end


@interface DeviceInfo : NSObject
@property(strong) NSString * ipAddr;
@property(strong) NSString * macAddr;

@end