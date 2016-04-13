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



@interface PhoneInfoViewController ()//<BaiduMobAdViewDelegate>

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
        
        
        
        CGFloat yPos = 0;
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
    
    [self layoutADV];
}




- (NSString *)publisherId
{
    return  BAIDU_APP_ID;
}


-(void)layoutADV
{
    /*
    //顶部
    BaiduMobAdView * _baiduView = [[BaiduMobAdView alloc]init];
    _baiduView.AdUnitTag = BAIDU_ADV_ID;
    _baiduView.AdType = BaiduMobAdViewTypeBanner;
    _baiduView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -60, kBaiduAdViewBanner468x60.width, kBaiduAdViewBanner468x60.height);
    _baiduView.delegate = self;
    [self.view addSubview:_baiduView];
    [_baiduView start];
     */
    
    CGPoint pt ;
    
    pt = CGPointMake(0, [UIScreen mainScreen].bounds.size.height -60);
    GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner origin:pt];
    
    _bannerView.adUnitID = ADMOB_ADV_ID;
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    [self.view addSubview:_bannerView];

    
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
