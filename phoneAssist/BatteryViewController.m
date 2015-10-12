//
//  BatteryViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "BatteryViewController.h"
#import "SystemServices.h"


#define SystemSharedServices [SystemServices sharedServices]



@interface BatteryViewController ()
{
    CGFloat firstBatteryLevel;
    NSDate * curBatteryTime;
}
@property (weak, nonatomic) IBOutlet UILabel *batteryTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *batteryImgView;
@property (weak, nonatomic) IBOutlet UILabel *batteryStateLab;



@end

@implementation BatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电池状态";
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //
    [self drawBattery];
    
    [self getBatteryTime];
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////电池电量---begin//////////////////////////////////////////////////

-(UIImage*)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

//电池百分比
-(CGFloat)getBatteryPercent
{
    return [SystemSharedServices batteryLevel]/100.0;
}

-(void)getBatteryTime
{
    firstBatteryLevel = [SystemSharedServices batteryLevel];
    curBatteryTime = [NSDate date];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(batteryCharged:)
     name:UIDeviceBatteryLevelDidChangeNotification
     object:nil
     ];
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(notiBattery) userInfo:nil repeats:NO];
}

-(void)notiBattery
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIDeviceBatteryLevelDidChangeNotification object:nil];
}

- (void)batteryCharged:(NSNotification *)note
{
    float currBatteryLev = [SystemSharedServices batteryLevel];
    
    if( [SystemSharedServices fullyCharged] )
    {
        _batteryTimeLab.text = @"已充满";
    }
    else if( [SystemSharedServices charging] )
    {
        float avgChgSpeed = (firstBatteryLevel-0.1 - currBatteryLev)*1.0 / [curBatteryTime timeIntervalSinceNow];
        
        float remBatteryLev = 100 - currBatteryLev;
        
        NSInteger remSeconds = remBatteryLev / avgChgSpeed;
        
        _batteryTimeLab.text = [NSString stringWithFormat:@"%02ld:%02ld",(remSeconds)/3600,((remSeconds)%3600)/60];
        
        if( ((remSeconds)/3600== 0) && ((remSeconds)%3600/60 == 0))
        {
            _batteryTimeLab.text = @"已充满";
        }
        else if( avgChgSpeed == 0 )
        {
            _batteryTimeLab.text = @"计算中...";
        }
    }
    //放电
    else
    {
        float avgChgSpeed = fabs((firstBatteryLevel - currBatteryLev)*1.0 / [curBatteryTime timeIntervalSinceNow]);
        
        NSInteger remSeconds = currBatteryLev / avgChgSpeed;
        
        _batteryTimeLab.text = [NSString stringWithFormat:@"%02ld:%02ld",(remSeconds)/3600,((remSeconds)%3600)/60];
        
        if( firstBatteryLevel - currBatteryLev == 0 )
        {
            _batteryTimeLab.text = [NSString stringWithFormat:@"%02d:%02d",23,55];
        }
    }
    
    [self drawBattery];
}

-(void)drawBattery
{
    for( UIView * view in [_batteryImgView subviews] )
    {
        [view removeFromSuperview];
    }
    
    //
    CGFloat precent = [self getBatteryPercent];
    CGRect frame = _batteryImgView.bounds;
    frame = CGRectMake(frame.origin.x, frame.origin.y+(1-precent)*frame.size.height, frame.size.width, frame.size.height*precent);
    
    CGImageRef imgRef = CGImageCreateWithImageInRect([[self scaleImage:[UIImage imageNamed:@"batteryUse"] toSize:CGSizeMake(_batteryImgView.frame.size.width, _batteryImgView.frame.size.height)] CGImage], frame);
    UIImage * image = [UIImage imageWithCGImage:imgRef];
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:frame];
    imgView.image = image;
    
    [_batteryImgView addSubview:imgView];
    
    //如果是充电
    if( [SystemSharedServices charging] )
    {
        _batteryStateLab.text = @"充电";
        
        if( [SystemSharedServices fullyCharged] || precent == 1 )
        {
            _batteryTimeLab.text = @"已充满";
        }
    }
    else
    {
        _batteryStateLab.text = @"放电";
        
        if( precent == 1 )
        {
            _batteryTimeLab.text = [NSString stringWithFormat:@"%02d:%02d",23,55];
        }
    }
}

/////////////////////////////////电池电量---end///////////////////////////////////////////////////

@end
