//
//  DownLoadTool.m
//  weizhangsuishoupai
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 li  bo. All rights reserved.
//

#import "DownLoadTool.h"
#import "NSDate+Helper.h"


/*
 url:H5广告页面
 forceScore:强制打分（1）
 appid:bundle id  区分APP
*/

@implementation DownLoadTool

+(NSDictionary*)downLoadWebAdv
{
    NSString * day = [NSString stringWithFormat:@"%d-%d-%d",[[NSDate date] year],[[NSDate date] month],[[NSDate date] day]];
    NSLog(@"day:%@",day);
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);//使用C函数NSSearchPathForDirectoriesInDomains来获得沙盒中目录的全路径。
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    NSString *documentPath = [ourDocumentPath  stringByAppendingPathComponent:@"webAdv.txt"];//将Documents添加到sandbox路径上//TestDownImgZip.app
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    BOOL bFlag = [def objectForKey:day];
    
    if( !bFlag )
    {
        [self downloadTextFile:WEB_ADV_URL file:documentPath];
        [def setBool:YES forKey:day];
        [def synchronize];
    }
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:documentPath];
    
    if( !data ) return nil;
    
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    for( NSDictionary * dic in jsonDic[@"webAdv"] )
    {
        if( [dic[@"appid"] isEqualToString:[self getBundleID]] )
        {
            if( [dic[@"url"] length] > 4)
            {
                return dic;
            }
        }
    }
    
    return nil;
}

+(void)downloadTextFile:(NSString*)fileUrl file:documentPath
{
    // Copy the database sql file from the resourcepath to the documentpath
    NSURL *url = [NSURL URLWithString:fileUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];

    NSError * error = nil;
    BOOL bFlag = [data writeToFile:documentPath options:NSDataWritingAtomic error:&error];
    
    NSLog(@"bFlag:%d error:%@",bFlag,error);
}

+(NSString*) getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

/*
 
 -(void)startWebAdvReq
 {
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 
 NSString * url = [DownLoadTool downLoadWebAdv][@"url"];
 if( url )
 {
 dispatch_async(dispatch_get_main_queue(), ^{
 
 WebAdvViewController * vc = [WebAdvViewController new];
 vc.url = url;
 
 [self presentViewController:vc animated:YES completion:nil];
 });
 }
 });
 }
 
 
 
 if( [[DownLoadTool downLoadWebAdv][@"forceScore"] isEqualToString:@"1"] )
 {
 return YES;
 }
 
 */

@end
