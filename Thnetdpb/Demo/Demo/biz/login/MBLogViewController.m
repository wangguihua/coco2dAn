//
//  MBLogViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-4.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "MBLogViewController.h"
#import "MBIIRequest.h"
#import "MBCommon.h"
#import "MBGlobalUICommon.h"
#import "MBUserInfo.h"
#import "MBConstant.h"
#import "AppDelegate.h"
@interface MBLogViewController ()<UITextFieldDelegate>
{
    float _normHeig;
}
@end

@implementation MBLogViewController

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
    self.title = @"登录";
    _normHeig= self.view.frame.origin.y;
    _countName.text = @"zengdongbiao";
    _pad.text = @"123456";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_countName]) {
        [self viewUP];
    }
    else if ([textField isEqual:_pad]) {
        [self viewUPTop];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_countName]) {
        
        [_pad becomeFirstResponder];
        
    }else
    {
        [textField resignFirstResponder];
        [self viewNor];
    }
    
    return YES;
}

-(void)viewUP{
    
    [UIView animateWithDuration:0.17 animations:^{
        
        self.view.frame =CGRectMake(self.view.frame.origin.x, _normHeig-60, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}
-(void)viewUPTop
{
    [UIView animateWithDuration:0.17 animations:^{
        
        self.view.frame =CGRectMake(self.view.frame.origin.x, _normHeig-60-60, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}
-(void)viewNor
{
    [UIView animateWithDuration:0.17 animations:^{
        
        self.view.frame =CGRectMake(self.view.frame.origin.x,_normHeig, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}
- (IBAction)logBtnPressed:(id)sender {
    
    NSDictionary *params = @{[MBUserLogInfo account]: _countName.text,[MBUserLogInfo password]: _pad.text};
    
    __block MBLogViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:[MBUserLogInfo method] params:params];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);

        [blockSelf logSuccess:JSON];
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];
    
}
-(void)logSuccess:(id)JSON
{
    if ([JSON[@"ret"] isEqualToString:@"0"]) {
        MBHUD(@"没账号", 1);
    }
    if ([JSON[@"ret"] isEqualToString:@"1"]) {
        MBHUD(@"没输入密码", 1);
    }
    if ([JSON[@"ret"] isEqualToString:@"2"]) {
        MBHUD(@"密码不对", 1);
    }
    if ([JSON[@"ret"] isEqualToString:@"3"]) {
        MBHUD(@"未激活", 1);
    }if ([JSON[@"ret"] isEqualToString:@"4"]) {
        
        MBHUD(@"登录成功", 1);
        
        MBUserInfo *userInflo =[MBUserInfo shareUserInfo];
        
        NSDictionary *param = @{[MBUserLogInfo account]: _countName.text,[MBUserLogInfo password]: _pad.text};
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
        [userInflo setUserInfo:params];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:UserISLogin];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        __block MBLogViewController *blockSelf = self;
        
        MBRequestItem *item = [MBRequestItem itemWithMethod:[MBUserAllInfo method] params:@{@"account": userInflo.userInfo[@"account"]}];
        [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
            
            NSLog(@"1111====%@",JSON);
            
            [userInflo setUserAllInfo:JSON];
            NSDictionary *userNeedInfo=JSON[@"ret"];
            
            NSDictionary *needSave =@{@"trueName": userNeedInfo[@"trueName"],@"ret.pos_id.info":MBNonEmptyStringNo_(userNeedInfo[@"pos_id"][@"info"]),@"ret.pos_id.dep_id.info":MBNonEmptyStringNo_(userNeedInfo[@"pos_id"][@"dep_id"][@"info"]),@"ret.pos_id.dep_id.units.info":userNeedInfo[@"pos_id"][@"dep_id"][@"units_id"][@"info"],@"id":MBNonEmptyStringNo_(userNeedInfo[@"id"])};
        
            [[NSUserDefaults standardUserDefaults]setObject:needSave forKey:USerAllInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
            

            [blockSelf getUserInfo:JSON];

            
        } failure:^(NSError *error, id JSON) {
            
            NSLog(@"1111====%@",JSON);
            MBHUD(@"网络不稳定，请重新请求", 1);

        }];
        
        
    }
}

- (void)getUserInfo:(id)JSON
{
    AppDelegate *appDele =[UIApplication sharedApplication].delegate;
    appDele.window.rootViewController = appDele.maiNav;
}
@end
