//
//  DownLoadTool.h
//  weizhangsuishoupai
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 li  bo. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DAY_STORE @"DAY_STORE"
#define WEB_ADV_URL @"http://www.feizhubaoxian.top/appAdv/webAdv.txt"
#define SELF_ADV_URL_BASE  @"www.feizhubaoxian.top"



@interface DownLoadTool : NSObject
+(NSDictionary*)downLoadWebAdv;
@end
