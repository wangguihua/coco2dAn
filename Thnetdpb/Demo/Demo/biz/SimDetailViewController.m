//
//  OneViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-5.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "SimDetailViewController.h"
#import "MBConstant.h"
@interface SimDetailViewController ()

@end

@implementation SimDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    NSLog(@"%@",userAllInfo);
    _content =[[UITextView alloc]initWithFrame:CGRectMake(0, 190, 320, 300)];
    [self.view addSubview:_content];
    _name.text = MBNonEmptyStringNo_(userAllInfo[@"trueName"]);
    _wordWeh.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.dep_id.units.info"]);
    _job.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.info"]);
    
    _content.text = _contenStr;
    _itemLabel.text = _titelStr;
    
    if (kScreenHeight<500) {
        _content.frame = CGRectMake(_content.frame.origin.x, _content.frame.origin.y, 320, self.view.frame.size.height-190);
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_content setEditable:NO];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
