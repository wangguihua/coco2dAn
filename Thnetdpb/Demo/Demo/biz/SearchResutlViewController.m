//
//  SearchResutlViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-6.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "SearchResutlViewController.h"

@interface SearchResutlViewController ()

@end

@implementation SearchResutlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@",_resutlID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
