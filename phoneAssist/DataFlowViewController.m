//
//  DataFlowViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "DataFlowViewController.h"
#import "CommInfo.h"
#import "SystemServices.h"
#import "CommData.h"


#define SystemSharedServices [SystemServices sharedServices]


@interface DataFlowViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flowLab;

@end


@implementation DataFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //
    
    [self drawNetFlow];
 
    self.title = @"流量监测";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/////////////////////////////////网络流量-----begin///////////////////////////////////////////////////

-(void)drawNetFlow
{
    _flowLab.text =  [self getNetMonthUse];
}

-(BOOL)twoDateSameMonth:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSMonthCalendarUnit ;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    
    return [comp1 month] == [comp2 month];
}

-(BOOL)twoDateSameTime:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    
    return ([comp1 year] == [comp2 year]) && ([comp1 year] == [comp2 year]) && ([comp1 day] == [comp2 day])&&([comp1 hour] == [comp2 hour])&&([comp1 minute] == [comp2 minute]);
}

-(NSString*)getNetMonthUse
{
    NetUseInfo * useInfo = [self getNetFromStore];
    if( !useInfo )
    {
        useInfo = [NetUseInfo new];
    }
    
    NSUInteger totalByte = 0;
    NSDate * powerDate = [SystemSharedServices getSystemPowerDate];
    NSDate * curDate = [NSDate date];
    NSDictionary * dataDict = [SystemSharedServices getDataCounters];
    
    if( [useInfo.lastDate isEqualToDate:powerDate] )
    {
        NSLog(@"equal");
    }
    
    //两次开机时间不同，且3个时间都在同一个月内，
    if( (![self twoDateSameTime:useInfo.lastDate date2:powerDate]) && [self twoDateSameMonth:curDate date2:powerDate ] &&  [self twoDateSameMonth:curDate date2:useInfo.lastDate ] )
    {
        totalByte = useInfo.lastByte + [dataDict[DataCounterKeyWWANSent] unsignedIntegerValue] +[dataDict[DataCounterKeyWWANReceived] unsignedIntegerValue];
        useInfo.lastDate = powerDate;
        useInfo.lastByte = totalByte;
    }
    else
    {
        totalByte = [dataDict[DataCounterKeyWWANSent] unsignedIntegerValue] +[dataDict[DataCounterKeyWWANReceived] unsignedIntegerValue];
        useInfo.lastDate = powerDate;
        useInfo.lastByte = totalByte;
    }
    
    [self setNetToStore:useInfo];
    
    //
    return [self tranByte:useInfo.lastByte];
}

-(NetUseInfo*)getNetFromStore
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_NET_INFO];
    
    NetUseInfo * useInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return useInfo;
}


-(void)setNetToStore:(NetUseInfo*)info
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [def setObject:data forKey:STORE_NET_INFO];
    
    [def synchronize];
}

-(NSString *)tranByte:(NSUInteger)byte
{
    if( byte*1.0 / 1073741824 >= 1 )
    {
        return [NSString stringWithFormat:@"%.2fG",byte*1.0 / 1073741824];
    }
    else if( byte*1.0 / 1048576 >= 1 )
    {
        return [NSString stringWithFormat:@"%.2fM",byte*1.0 / 1048576];
    }
    else if( byte*1.0 / 1024 >= 1 )
    {
        return [NSString stringWithFormat:@"%.2fK",byte*1.0 / 1024];
    }
    
    return @"";
}

/////////////////////////////////网络流量-----end///////////////////////////////////////////////////



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
