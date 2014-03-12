//
//  UserLocationViewController.m
//  Category_demo
//
//  Created by songjian on 13-3-21.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "UserLocationViewController.h"

@interface UserLocationViewController ()



@end

@implementation UserLocationViewController


- (void)returnAction
{
    [super returnAction];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btnone =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnone.frame= CGRectMake(40, 40, 50, 30);
    [btnone setTitle:@"返回" forState:UIControlStateNormal];
    [btnone addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnone];
    

    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
}

@end
