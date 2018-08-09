//
//  MemoryViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "MemoryViewController.h"
#import "SystemServices.h"
#import "PCPieChart.h"
#import "CommData.h"
//#import "BaiduMobAdView.h"

@import GoogleMobileAds;

#define SystemSharedServices [SystemServices sharedServices]

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE

@interface MemoryViewController ()//<BaiduMobAdViewDelegate>
{
    PCPieChart *pieChart;
    NSMutableArray *components;
}
@property (weak, nonatomic) IBOutlet UILabel *allMem;
@property (weak, nonatomic) IBOutlet UILabel *usedMem;
@property (weak, nonatomic) IBOutlet UILabel *wiredMem;
@property (weak, nonatomic) IBOutlet UILabel *actMem;
@property (weak, nonatomic) IBOutlet UILabel *inActMem;
@property (weak, nonatomic) IBOutlet UILabel *freeMem;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation MemoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Get all the memory info
    [self performSelector:@selector(getAllMemoryInformation)];
    
    // Get all the data
    components = [[NSMutableArray alloc] init];
    
    // Make the piechart view
    int yPosition = (isiPhone5) ? 150 : 150;
    int height = [[UIScreen mainScreen] bounds].size.width/3*2.; // 220;
    int width = [[UIScreen mainScreen] bounds].size.width - 7; //320;
    pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(0,yPosition,width,height)];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    [pieChart setSameColorLabel:YES];
    
    // Add the piechart to the view
    [_contentView addSubview:pieChart];
    
    // Set up for iPad and iPhone
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
    {
        pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
        pieChart.percentageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:50];
    }
    
    // Make all the components
    PCPieComponent *component1 = [PCPieComponent pieComponentWithTitle:@"总内存" value:[SystemSharedServices usedMemoryinPercent]];
    [component1 setColour:PCColorYellow];
    [components addObject:component1];
    
    PCPieComponent *component2 = [PCPieComponent pieComponentWithTitle:@"连续内存" value:[SystemSharedServices wiredMemoryinPercent]];
    [component2 setColour:PCColorGreen];
    [components addObject:component2];
    
    PCPieComponent *component3 = [PCPieComponent pieComponentWithTitle:@"活动内存" value:[SystemSharedServices activeMemoryinPercent]];
    [component3 setColour:PCColorOrange];
    [components addObject:component3];
    
    PCPieComponent *component4 = [PCPieComponent pieComponentWithTitle:@"挂起内存" value:[SystemSharedServices inactiveMemoryinPercent]];
    [component4 setColour:PCColorRed];
    [components addObject:component4];
    
    PCPieComponent *component5 = [PCPieComponent pieComponentWithTitle:@"空闲内存" value:[SystemSharedServices freeMemoryinPercent]];
    [component5 setColour:PCColorBlue];
    [components addObject:component5];
    
    
    // Set all the componenets
    [pieChart setComponents:components];
    
    self.title = @"内存信息";
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //
    [self layoutADV];
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
    
    pt = CGPointMake(0, 0);
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

// Get all the memory information and put it on the labels
- (void)getAllMemoryInformation
{
    
     // Amount of Memory (RAM)
     self.allMem.text = [NSString stringWithFormat:@"总内存:   %.2f MB",[SystemSharedServices totalMemory]];
     
     // Used Memory
     self.usedMem.text = [NSString stringWithFormat:@"使用内存: %.2f MB %.0f%%", [SystemSharedServices usedMemoryinRaw], [SystemSharedServices usedMemoryinPercent]];
     //[self.lblUsedMemory setTextColor:PCColorYellow];
     
     // Wired Memory
     self.wiredMem.text = [NSString stringWithFormat:@"连续内存: %.2f MB %.0f%%", [SystemSharedServices wiredMemoryinRaw], [SystemSharedServices wiredMemoryinPercent]];
     //[self.lblWiredMemory setTextColor:PCColorGreen];
     
     // Active Memory
     self.actMem.text = [NSString stringWithFormat:@"活动内存: %.2f MB %.0f%%", [SystemSharedServices activeMemoryinRaw], [SystemSharedServices activeMemoryinPercent]];
     //[self.lblActiveMemory setTextColor:PCColorOrange];
     
     // Inactive Memory
     self.inActMem.text = [NSString stringWithFormat:@"挂起内存: %.2f MB %.0f%%", [SystemSharedServices inactiveMemoryinRaw], [SystemSharedServices inactiveMemoryinPercent]];
     //[self.lblInactiveMemory setTextColor:PCColorRed];
     
     // Free Memory
     self.freeMem.text = [NSString stringWithFormat:@"空闲内存: %.2f MB %.0f%%", [SystemSharedServices freeMemoryinRaw], [SystemSharedServices freeMemoryinPercent]];
     //[self.lblFreeMemory setTextColor:PCColorBlue];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
                                duration:(NSTimeInterval)duration{
    NSLog(@"Frame: %f, %f, %f, %f", pieChart.frame.origin.x, pieChart.frame.origin.y, pieChart.frame.size.width, pieChart.frame.size.height);
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
