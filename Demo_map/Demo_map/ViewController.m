//
//  ViewController.m
//  Demo_map
//
//  Created by llbt_wgh on 14-3-9.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "ViewController.h"
#import "BaseMapViewController.h"
#import "UserLocationViewController.h"
#import "NavViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame= CGRectMake(0, 40, 50, 30);
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showsUserLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btnone =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnone.frame= CGRectMake(140, 40, 150, 30);
    [btnone setTitle:@"当前位置到天安门路径" forState:UIControlStateNormal];
    [btnone addTarget:self action:@selector(showsUserLocationPath) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnone];
    
  
}
-(void)showsUserLocationPath
{
    NSString *className = @"NavViewController";

    BaseMapViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title   = @"路径";
    subViewController.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    subViewController.search  = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    
    
    [self presentViewController:subViewController animated:YES completion:nil];
}
-(void)showsUserLocation
{
    NSString *className = @"UserLocationViewController";
    
    BaseMapViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title   = @"定位";
    subViewController.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    subViewController.search  = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
    
    
    [self presentViewController:subViewController animated:YES completion:nil];
    
}

@end
