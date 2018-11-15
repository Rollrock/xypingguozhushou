//
//  PhoneInfoViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "PhoneInfoViewController.h"
#import "SystemServices.h"
#import "SSAccelerometerInfo.h"
#import "NSObject+PerformBlockAfterDelay.h"
#import "CommData.h"
//#import "BaiduMobAdView.h"

@import GoogleMobileAds;

#define SystemSharedServices [SystemServices sharedServices]



#define LAB_VIEW_BG_COLOR  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]//[UIColor grayColor]

@interface PhoneInfoViewController ()

@end

@implementation PhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    
        self.title = @"系统信息";
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        NSArray * itemArray = @[@"     手机名字:  ",@"     手机类型:  ",@"     系统版本:  ",@"     运行时间:  ",@"     屏幕大小:  ",@"     屏幕亮度:  ",@"     剩余电量:  ",@"     当前国家:  ",@"     当天语言:  ",@"     当前时区:  "];
        
        UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:scrView];
    
    
        CGFloat yPos = 60;
        int index = 0;
        int const VIEW_HEIGHT = 35;
        UIFont * font = [UIFont systemFontOfSize:15];
    
        {
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices deviceName]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices systemDeviceTypeFormatted]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices systemsVersion]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            NSArray *uptimeFormat = [[SystemSharedServices systemsUptime] componentsSeparatedByString:@" "];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@天%@时%@分",itemArray[index++],[uptimeFormat objectAtIndex:0], [uptimeFormat objectAtIndex:1], [uptimeFormat objectAtIndex:2]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%ldX%ld",itemArray[index++],(long)[SystemSharedServices screenWidth],(long)[SystemSharedServices screenHeight]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%.0f%%",itemArray[index++],[SystemSharedServices screenBrightness]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%.0f%%",itemArray[index++],[SystemSharedServices batteryLevel]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices country]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices language]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices timeZoneSS]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
    
    [self layoutADV:scrView];
}

-(void)layoutADV:(UIView*)parentView
{
  
    CGPoint pt ;
    
    pt = CGPointMake(0, 0);//[UIScreen mainScreen].bounds.size.height -60);
    GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
    
    _bannerView.adUnitID = ADMOB_ADV_ID;
    _bannerView.rootViewController = self;
    
    GADRequest * req = [GADRequest request];
    
    req.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
    [_bannerView loadRequest:req];
    
    [parentView addSubview:_bannerView];
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
