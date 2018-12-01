//
//  MainViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/9.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "MainViewController.h"
#import "UIScrollView+UITouch.h"
#import "SignViewController2.h"
#import "NetSpeedViewController.h"
#import "NetSpyViewController.h"
#import "CommData.h"
#import "BatteryViewController.h"
#import "PhoneInfoViewController.h"
#import "DataFlowViewController.h"
#import "MemoryViewController.h"
#import "DiskViewController.h"
#import "APPsViewController.h"
#import "WebViewController.h"
#import "NewsViewController.h"
#import "DownLoadTool.h"
#import "WebAdvViewController.h"

#import "AdvertViewController.h"
#import "SystemServices.h"

#define SystemSharedServices [SystemServices sharedServices]

@import GoogleMobileAds;

//
@interface MainViewController ()<GADInterstitialDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_1;
@property (weak, nonatomic) IBOutlet UIView *view_2;
@property (weak, nonatomic) IBOutlet UIView *view_3;
@property (weak, nonatomic) IBOutlet UIView *view_4;
@property (weak, nonatomic) IBOutlet UIView *view_5;
@property (weak, nonatomic) IBOutlet UIView *view_6;
@property (weak, nonatomic) IBOutlet UIView *view_7;
@property (weak, nonatomic) IBOutlet UIView *view_8;
@property (weak, nonatomic) IBOutlet UIView *view_9;
@property (weak, nonatomic) IBOutlet UIView *advView;
@property (weak, nonatomic) IBOutlet UIView *advView2;

@property (weak, nonatomic) IBOutlet UILabel *appLab;

@property (weak, nonatomic) IBOutlet UIImageView *appImg;

@property(nonatomic, strong) GADInterstitial *interstitial;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"手机信息";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    UIColor *color = [UIColor whiteColor];
    UIFont * font = [UIFont systemFontOfSize:20];
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:@[color,font] forKeys:@[NSForegroundColorAttributeName ,NSFontAttributeName]];
    self.navigationController.navigationBar.titleTextAttributes = dict;

    //
    [self layoutADV];
    
    [self createAndLoadInterstitial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.interstitial.isReady)
    {
        [self.interstitial presentFromRootViewController:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    
    CGPoint pt;
    
    pt = [t locationInView:_view_1];
    
    if( CGRectContainsPoint(_view_1.bounds, pt) )
    {
        SignViewController2 * vc = [[SignViewController2 alloc]initWithNibName:@"SignViewController2" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_2];
    if( CGRectContainsPoint(_view_2.bounds, pt) )
    {
        DataFlowViewController * vc = [[DataFlowViewController alloc]initWithNibName:@"DataFlowViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_3];
    if( CGRectContainsPoint(_view_3.bounds, pt) )
    {
        NetSpeedViewController * vc = [[NetSpeedViewController alloc]initWithNibName:@"NetSpeedViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_4];
    if( CGRectContainsPoint(_view_4.bounds, pt) )
    {
        NetSpyViewController * vc = [[NetSpyViewController alloc]initWithNibName:@"NetSpyViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_5];
    if( CGRectContainsPoint(_view_5.bounds, pt) )
    {
        DiskViewController * vc = [[DiskViewController alloc]initWithNibName:@"DiskViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    
    pt = [t locationInView:_view_6];
    if( CGRectContainsPoint(_view_6.bounds, pt) )
    {
        MemoryViewController * vc = [[MemoryViewController alloc]initWithNibName:@"MemoryViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    
    pt = [t locationInView:_view_7];
    if( CGRectContainsPoint(_view_7.bounds, pt) )
    {
        BatteryViewController * vc = [[BatteryViewController alloc]initWithNibName:@"BatteryViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_8];
    if( CGRectContainsPoint(_view_8.bounds, pt) )
    {
        PhoneInfoViewController * vc = [[PhoneInfoViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    pt = [t locationInView:_view_9];
    if( CGRectContainsPoint(_view_9.bounds, pt) )
    {

        AdvertViewController * vc = [AdvertViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
/*
        if(![self showApps] )
        {
            return;
        }
        
        int rand = arc4random() % 2;
        
        if( rand == 0 )
        {
            //APP推广
            AdvertViewController * vc = [AdvertViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //web
            
            NSString * url = [DownLoadTool downLoadWebAdv][@"url"];
            WebAdvViewController * vc = [WebAdvViewController new];
            vc.url = url;
            if( [url length] > 0 )
            {
                [self presentViewController:vc animated:YES completion:nil];
            }
            else
            {
                //APP推广页面
                AdvertViewController * vc = [AdvertViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
        
        return;
 
 */
    }
}

-(void)layoutADV
{
    //
    {
        CGPoint pt ;
        
        pt = CGPointMake(0, 0);
        GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
        
        _bannerView.adUnitID = ADMOB_ADV_ID;
        _bannerView.rootViewController = self;
        GADRequest * req = [GADRequest request];
        req.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
        [_bannerView loadRequest:req];
        
        [_advView2 addSubview:_bannerView];
    }
    
    //
    {
        CGPoint pt ;
        
        pt = CGPointMake(0, 0);
        GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:pt];
        
        _bannerView.adUnitID = ADMOB_ADV_ID_2;
        _bannerView.rootViewController = self;
            
        GADRequest * req = [GADRequest request];
        req.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
        [_bannerView loadRequest:req];
        
        [_advView addSubview:_bannerView];
    }
}


- (void)createAndLoadInterstitial {
    self.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:ADMOB_ADV_INSERT_ID];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADInterstitial automatically returns test ads when running on a
    // simulator.
    
    [self.interstitial loadRequest:request];
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
}


-(BOOL)showApps
{
    if( [[DownLoadTool downLoadWebAdv][@"showAdvs"] isEqualToString:@"1"] )
    {
        return YES;
    }
    
    
    NSDateComponents * data = [[NSDateComponents alloc]init];
    NSCalendar * cal = [NSCalendar currentCalendar];
    
    [data setCalendar:cal];
    [data setYear:SHOW_APP_YEAR];
    [data setMonth:SHOW_APP_MONTH];
    [data setDay:SHOW_APP_DAY];
    
    
    NSDate * farDate = [cal dateFromComponents:data];
    
    NSDate *now = [NSDate date];
    
    NSTimeInterval farSec = [farDate timeIntervalSince1970];
    NSTimeInterval nowSec = [now timeIntervalSince1970];
    
    if( nowSec - farSec >= 0 )
    {
        return YES;
    }
    
    return NO;
}


@end
