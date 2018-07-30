//
//  WebAdvViewController.m
//  weizhangsuishoupai
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 li  bo. All rights reserved.
//

#import "WebAdvViewController.h"
#import "DownLoadTool.h"

@import GoogleMobileAds;

@interface WebAdvViewController ()<GADBannerViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *advView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebAdvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layoutAdv];
    
    if( self.url )
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        self.webView.delegate = self;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutAdv
{
    GADBannerView * banner = [[GADBannerView alloc]initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    banner.rootViewController = self;
    banner.adUnitID = @"ca-app-pub-3058205099381432/3915883847";
    [self.advView addSubview:banner];
    banner.delegate = self;
    
    GADRequest *req = [GADRequest request];
    req.testDevices = @[@"02257fbde9fc053b183b97056fe93ff4"];
    [banner loadRequest:req];
}

- (IBAction)backClicked {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if( [request.URL.absoluteString rangeOfString:SELF_ADV_URL_BASE].length == 0 )
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}



@end
