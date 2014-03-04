//
//  MBMainViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-4.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "MBMainViewController.h"
#import "MBUserInfo.h"
#import "MBConstant.h"
#import "AppDelegate.h"
#import "OneViewController.h"
#import "MBIIRequest.h"
#import "MBCommon.h"
#import "MBGlobalUICommon.h"
#import "TwoViewController.h"
@interface MBMainViewController ()

@end

@implementation MBMainViewController

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
    self.title= @"菜单";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(loginOut)];
    
    _nieBuSel =[[MBSelectView alloc]initWithFrame:CGRectMake(15, 150, 95, 25)];
    _nieBuSel.options = @[@"内部结构"];
    [self.view addSubview:_nieBuSel];
    
    _linDaSel =[[MBSelectView alloc]initWithFrame:CGRectMake(115, 150, 95, 25)];
    _linDaSel.options = @[@"领导职务"];
    [self.view addSubview:_linDaSel];
    
    _persoSel =[[MBSelectView alloc]initWithFrame:CGRectMake(218, 150, 95, 25)];
    _persoSel.options = @[@"个人名称"];
    [self.view addSubview:_persoSel];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];

    NSLog(@"%@",userAllInfo);
    _name.text = MBNonEmptyStringNo_(userAllInfo[@"trueName"]);
    _wordWhere.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.dep_id.units.info"]);
    _kezhang.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.dep_id.info"]);
    _job.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.info"]);



}
-(void)loginOut
{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:UserISLogin];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    AppDelegate *appDele =[UIApplication sharedApplication].delegate;
    appDele.window.rootViewController = appDele.logNav;
    
    
}


- (IBAction)oneBtnPressed:(id)sender {
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];

    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"1"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf getContnSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

    

    
}
-(void)getContnSuccess:(id)JSON
{
    NSString *contenStr =MBNonEmptyStringNo_(JSON[@"ret"][0][@"content"]);
    OneViewController *oneVC =[[OneViewController alloc]initWithNibName:@"OneViewController" bundle:nil];
    oneVC.contenStr = contenStr;
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (IBAction)twoBtnPressed:(id)sender{
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"2"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf twoGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];
    
}
-(void)twoGetSuccess:(id)JSON
{
    NSString *contenStr =MBNonEmptyStringNo_(JSON[@"ret"][0][@"content"]);
    TwoViewController *oneVC =[[TwoViewController alloc]initWithNibName:@"TwoViewController" bundle:nil];
    oneVC.contenStr = contenStr;
    [self.navigationController pushViewController:oneVC animated:YES];
    
}
- (IBAction)thrBtnPressed:(id)sender{
}
- (IBAction)fouBtnPressed:(id)sender{
}
- (IBAction)fivBtnPressed:(id)sender{
}
- (IBAction)sixBtnPressed:(id)sender{
}
- (IBAction)sevBtnPressed:(id)sender{
}
- (IBAction)searchBtnPressed:(id)sender {
}
@end
