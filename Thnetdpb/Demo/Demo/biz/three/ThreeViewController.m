//
//  ThreeViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-5.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "ThreeViewController.h"
#import "MBConstant.h"
#import "CustomCell.h"
#import "MBIIRequest.h"
#import "MBGlobalCore.h"
#import "MBGlobalUICommon.h"
#import "SimDetailViewController.h"
@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ThreeViewController

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
    _name.text = MBNonEmptyStringNo_(userAllInfo[@"trueName"]);
    _wordWeh.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.dep_id.units.info"]);
    _job.text = MBNonEmptyStringNo_(userAllInfo[@"ret.pos_id.info"]);
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITableView*_accTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44+140, kScreenWidth, kContentViewHeight)];
    _accTableView.dataSource=self;
    _accTableView.delegate=self;
    _accTableView.showsVerticalScrollIndicator=NO;
    _accTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_accTableView];
    _accTableView.backgroundView=nil;
    self.title=@"执法程序";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr =@"CELLSTR";
    CustomCell *cell =[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell =[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.headImageView.image=[UIImage imageNamed:@"3.png"];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor =[UIColor whiteColor];
    }else{
    
        cell.backgroundColor =kStepViewTextColor;
    }
    NSDictionary *dicOF =_itemArray[indexPath.row];
    cell.itemLbl.text =MBNonEmptyStringNo_(dicOF[@"title"]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block ThreeViewController *blockSelf = self;
    
    MBRequestItem *item = [MBRequestItem itemWithMethod:@"i_loadInfo1.action" params:@{@"infoId": _itemArray[indexPath.row][@"id"],@"keyWord":@"THREE"}];
    
    [MBIIRequest requestWithItems:[NSArray arrayWithObject:item] success:^(id JSON) {
        
        NSLog(@"1111====%@",JSON);
        
        
        
        [blockSelf getAllInfoSuccess:JSON];
        
        
    } failure:^(NSError *error, id JSON) {
        
        NSLog(@"1111====%@",JSON);
        MBHUD(@"网络不稳定，请重新请求", 1);
        
    }];

}

-(void)getAllInfoSuccess:(id)JSON
{
    SimDetailViewController *oneVC =[[SimDetailViewController alloc]initWithNibName:@"SimDetailViewController" bundle:nil];
    oneVC.titelStr=MBNonEmptyStringNo_(JSON[@"ret"][@"title"]);
    oneVC.contenStr = MBNonEmptyStringNo_(JSON[@"ret"][@"content"]);
    oneVC.title=@"执法程序详情";
    [self.navigationController pushViewController:oneVC animated:YES];
    
}
@end
