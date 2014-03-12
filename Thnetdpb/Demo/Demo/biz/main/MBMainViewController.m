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
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "SearchResutlViewController.h"
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
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"1",@"keyWord":@"ALL"}];
    
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
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"2",@"keyWord":@"ALL"}];
    
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
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"3",@"keyWord":@"ALL"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        [blockSelf thrGetSuccess:JSON];
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

    
}
-(void)thrGetSuccess:(id)JSON
{
    NSArray *array = JSON[@"ret"];
    ThreeViewController *oneVC =[[ThreeViewController alloc]initWithNibName:@"ThreeViewController" bundle:nil];
    oneVC.itemArray = [array copy];
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (IBAction)fouBtnPressed:(id)sender{
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"4",@"keyWord":@"ALL"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf fourGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

}

-(void)fourGetSuccess:(id)JSON
{
    NSArray *array = JSON[@"ret"];
    FourViewController *oneVC =[[FourViewController alloc]initWithNibName:@"FourViewController" bundle:nil];
    oneVC.itemArray = [array copy];
    [self.navigationController pushViewController:oneVC animated:YES];
}

- (IBAction)fivBtnPressed:(id)sender{
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"5",@"keyWord":@"ALL"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf fiveGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

}

-(void)fiveGetSuccess:(id)JSON
{
    NSArray *array = JSON[@"ret"];
    FiveViewController *oneVC =[[FiveViewController alloc]initWithNibName:@"FiveViewController" bundle:nil];
    oneVC.itemArray = [array copy];
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (IBAction)sixBtnPressed:(id)sender{
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"6",@"keyWord":@"ALL"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf sixGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

}

-(void)sixGetSuccess:(id)JSON
{
    NSArray *array = JSON[@"ret"];
    SixViewController *oneVC =[[SixViewController alloc]initWithNibName:@"SixViewController" bundle:nil];
    oneVC.itemArray = [array copy];
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (IBAction)sevBtnPressed:(id)sender{
    
    NSDictionary *userAllInfo = [[NSUserDefaults standardUserDefaults]valueForKey:USerAllInfo];
    
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo.action" params:@{@"id": userAllInfo[@"id"],@"type":@"7",@"keyWord":@"ALL"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf senGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

    
}

-(void)senGetSuccess:(id)JSON
{
    NSArray *array = JSON[@"ret"];
    SevenViewController *oneVC =[[SevenViewController alloc]initWithNibName:@"SevenViewController" bundle:nil];
    oneVC.itemArray = [array copy];
    [self.navigationController pushViewController:oneVC animated:YES];
}
- (IBAction)searchBtnPressed:(id)sender {
    
    
    SearchResutlViewController *oneVC =[[SearchResutlViewController alloc]initWithNibName:@"SearchResutlViewController" bundle:nil];
//    oneVC.resutlID = [JSON copy];
    oneVC.title=@"搜索结果";
    [self.navigationController pushViewController:oneVC animated:YES];
    return;
    
    __block MBMainViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"q_query.action" params:@{@"condition":_searchKey.text,@"keyWord":@"search"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf searchGetSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)searchGetSuccess:(id)JSON
{
    SearchResutlViewController *oneVC =[[SearchResutlViewController alloc]initWithNibName:@"SearchResutlViewController" bundle:nil];
    oneVC.resutlID = [JSON copy];
    oneVC.title=@"搜索结果";
    [self.navigationController pushViewController:oneVC animated:YES];
}
@end
