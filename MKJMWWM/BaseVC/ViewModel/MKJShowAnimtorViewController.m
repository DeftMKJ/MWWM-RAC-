
//
//  MKJShowAnimtorViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/3.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJShowAnimtorViewController.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <PNChart.h>
#import <Masonry.h>
#import <FBShimmeringView.h>


@interface MKJShowAnimtorViewController ()

@property (nonatomic,strong) FBShimmeringView *shimmeringView;
@property (nonatomic,strong) PNRadarChart *radarChart;

@end

@implementation MKJShowAnimtorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.shimmeringView];
    [self.shimmeringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(([UIScreen mainScreen].bounds.size.width - 104) / 2, ([UIScreen mainScreen].bounds.size.height-288) / 3));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://sc0.hao123img.com/data/2017-02-23/1_78858744caabdeb66e298e1fa2077b24_510"]];
    

    // 用imageView加载到shimmering里面
    self.shimmeringView.contentView = imageView;
    
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    FBShimmeringView *view1 = [[FBShimmeringView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.shimmeringView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(([UIScreen mainScreen].bounds.size.width - 104), ([UIScreen mainScreen].bounds.size.height-288) / 3 * 1.8));
    }];
    
    
    NSArray *items = @[[PNRadarChartDataItem dataItemWithValue:10 description:@"身高"],
                       [PNRadarChartDataItem dataItemWithValue:80 description:@"身材"],
                       [PNRadarChartDataItem dataItemWithValue:90 description:@"气质"],
                       [PNRadarChartDataItem dataItemWithValue:50 description:@"颜值"],
                       [PNRadarChartDataItem dataItemWithValue:98 description:@"价格"],
                       ];
    self.radarChart = [[PNRadarChart alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH - 104 , ([UIScreen mainScreen].bounds.size.height-288) / 3 * 1.8) items:items valueDivider:1];
    
    self.radarChart.fontSize = 12;
    self.radarChart.maxValue = 100;
    self.radarChart.valueDivider = 10;
    self.radarChart.labelStyle = PNRadarChartLabelStyleHorizontal;
    
    [self.radarChart strokeChart];
    [view1 addSubview:self.radarChart];
    
}

- (FBShimmeringView *)shimmeringView
{
    if (_shimmeringView == nil) {
       _shimmeringView = [[FBShimmeringView alloc] init];
        _shimmeringView.shimmering = YES;
        
        _shimmeringView.shimmeringOpacity = 1;
        
        _shimmeringView.shimmeringDirection = FBShimmerDirectionLeft;
        
        _shimmeringView.shimmeringBeginFadeDuration = 0.3;
        
        _shimmeringView.shimmeringPauseDuration = 1.5;
        
        _shimmeringView.shimmeringHighlightWidth = 0.9;
        
        _shimmeringView.shimmeringSpeed = 150;
        _shimmeringView.layer.cornerRadius = 10;
        _shimmeringView.clipsToBounds = YES;
        _shimmeringView.backgroundColor = [UIColor whiteColor];
    }
    return _shimmeringView;
}

- (RACSubject *)subSignal
{
    if (!_subSignal) {
        _subSignal = [RACSubject subject];
    }
    return _subSignal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
         [self.subSignal sendNext:@"呵呵"];
    }];
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
