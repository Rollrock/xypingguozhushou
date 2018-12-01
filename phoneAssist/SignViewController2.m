//
//  SignViewController.m
//  NewiPhoneADV
//
//  Created by zhuang chaoxiao on 15/8/13.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

//签到

#import "SignViewController2.h"
#import "commData.h"
#import "CommInfo.h"
#import "AppDelegate.h"

@import GoogleMobileAds;


#define SIGN_PER_SCORE    2

@interface SignViewController2 ()</*BaiduMobAdViewDelegate,*/UIAlertViewDelegate,GADInterstitialDelegate>
{
    SignInfo * signInfo;
}
- (IBAction)signClicked;
- (IBAction)ReChargeClicked;
@property (weak, nonatomic) IBOutlet UIView *advBgView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation SignViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createAndLoadInterstitial];
    
    self.title = @"天天签到";
    
    [self getSignInfo];
    
    if( [self dateSame:[NSDate date] date2:signInfo.lastDate] )
    {
        _signBtn.enabled = NO;
        [_signBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
    }
    else
    {
        _signBtn.enabled = YES;
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
    }
    
    //搞个初始化随机数
    if( signInfo.score == 0 )
    {
        //
        int rand = arc4random() % 5;
        if( rand == 0 )
        {
            signInfo.score = 18;
        }
        else if( rand == 1 )
        {
            signInfo.score = 28;
        }
        else if( rand == 2 )
        {
            signInfo.score = 38;
        }
        else
        {
            signInfo.score = 8;
        }
    }
    
    _moneyLab.text = [NSString stringWithFormat:@"%ld元",signInfo.score];
    
    //
    [self layoutADV];
    //
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)layoutADV
{
    CGPoint pt ;
    
    pt = CGPointMake(0, 0);
    GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner origin:pt];
    
    _bannerView.adUnitID = ADMOB_ADV_SIGN_ID;
    _bannerView.rootViewController = self;
    [_bannerView loadRequest:[GADRequest request]];
    
    [_advBgView addSubview:_bannerView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSignInfo
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_SIGN_INFO];
    
    signInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if( ! signInfo )
    {
        signInfo = [SignInfo new];
    }
}

-(void)setSignInfo
{
    signInfo.lastDate = [NSDate date];
    signInfo.score += SIGN_PER_SCORE;
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:signInfo];
    [def setObject:data forKey:STORE_SIGN_INFO];
    [def synchronize];
    
    //
    _signBtn.enabled = NO;
    [_signBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
    
    //
    _moneyLab.text = [NSString stringWithFormat:@"%ld元",signInfo.score];
}

-(BOOL)dateSame:(NSDate*)date1 date2:(NSDate*)date2
{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    
    if ((int)(([date1 timeIntervalSince1970] + timezoneFix)/(24*3600)) - (int)(([date2 timeIntervalSince1970] + timezoneFix)/(24*3600)) == 0)
    {
        return YES;
    }
    
    return NO;
}

- (IBAction)signClicked
{
    [self setSignInfo];
    
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.interstitial.isReady) {
            [self.interstitial presentFromRootViewController:self];
        }
    });
}

- (IBAction)ReChargeClicked
{
    if( signInfo.score < 100)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的余额不足，充值最少需要100元" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"充值前请先给5星+好评吧~~" delegate:self cancelButtonTitle:@"现在就去" otherButtonTitles:@"不了", nil];
        alert.tag = 10086;
        [alert show];

    }
}

#pragma UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( (alertView.tag == 10086) && (buttonIndex == 0) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppStoreAddress]];
    }
}
//

- (void)createAndLoadInterstitial {
    self.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:ADMOB_ADV_INSERT_SIGN_ID];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"02257fbde9fc053b183b97056fe93ff4" ];
    
    [self.interstitial loadRequest:request];
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    //[self startNewGame];
}
@end
