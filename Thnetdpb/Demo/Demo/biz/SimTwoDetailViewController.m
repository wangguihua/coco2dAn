//
//  OneViewController.m
//  Demo
//
//  Created by llbt_wgh on 14-3-5.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "SimTwoDetailViewController.h"
#import "MBConstant.h"
#import "MBGlobalUICommon.h"
@interface SimTwoDetailViewController ()
{
    UIScrollView *_contenScroll;
}
@end

@implementation SimTwoDetailViewController

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
    
    MBHUD(@"左右滑动切换上下页！", 1);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [_content setUserInteractionEnabled:NO];

    _contenScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 145, kScreenWidth, kContentViewHeight)];
    _contenScroll.backgroundColor = [UIColor clearColor];
    _contenScroll.pagingEnabled = YES;
    _contenScroll.contentSize = CGSizeMake(_contenArray.count*(kScreenWidth), kContentViewHeight);
    _contenScroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_contenScroll];
    
    for (int i=0; i<_contenArray.count; i++) {
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(i*320+10, 0, 320, 35)];
        label.text=[NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)_contenArray.count];
        label.font=kNormalTextFont;
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=kNormalTextColor;
        [_contenScroll addSubview:label];
        
        
        
        UILabel *labelONe =[[UILabel alloc]initWithFrame:CGRectMake(i*320+10, 35, 320, 35)];
        labelONe.text=@"风险点类型";
        labelONe.font=kNormalTextFont;
        labelONe.textAlignment=NSTextAlignmentLeft;
        labelONe.textColor=kNormalTextColor;
        [_contenScroll addSubview:labelONe];
        
        UILabel *lablabelONeel =[[UILabel alloc]initWithFrame:CGRectMake(i*320+20, 70, 320, 35)];
        lablabelONeel.text=MBNonEmptyStringNo_(_contenArray[i][@"title"]);
        lablabelONeel.font=kNormalTextFont;
        lablabelONeel.textAlignment=NSTextAlignmentLeft;
        lablabelONeel.textColor=kNormalTextColor;
        [_contenScroll addSubview:lablabelONeel];
        
        UILabel *labelTwo =[[UILabel alloc]initWithFrame:CGRectMake(i*320+10, 105, 320, 35)];
        labelTwo.text=@"风险等级";
        labelTwo.font=kNormalTextFont;
        labelTwo.textAlignment=NSTextAlignmentLeft;
        labelTwo.textColor=kNormalTextColor;
        [_contenScroll addSubview:labelTwo];
        
        UILabel *labelTwoVal =[[UILabel alloc]initWithFrame:CGRectMake(i*320+20, 140, 320, 35)];
        labelTwoVal.text=MBNonEmptyStringNo_(_contenArray[i][@"lv"]);
        labelTwoVal.font=kNormalTextFont;
        labelTwoVal.textAlignment=NSTextAlignmentLeft;
        labelTwoVal.textColor=kNormalTextColor;
        [_contenScroll addSubview:labelTwoVal];
        
        
        UILabel *labelThre =[[UILabel alloc]initWithFrame:CGRectMake(i*320+10, 175, 320, 35)];
        labelThre.text=@"防范措施";
        labelThre.font=kNormalTextFont;
        labelThre.textAlignment=NSTextAlignmentLeft;
        labelThre.textColor=kNormalTextColor;
        [_contenScroll addSubview:labelThre];
        
        UITextView *feile =[[UITextView alloc]initWithFrame:CGRectMake(i*320+20, 210, 280, _contenScroll.frame.size.height-35)];
        feile.text=MBNonEmptyStringNo_(_contenArray[i][@"content"]);
        feile.font=kNormalTextFont;
        feile.textColor=kNormalTextColor;
        feile.pagingEnabled=YES;
        feile.editable=NO;
        feile.showsHorizontalScrollIndicator=NO;
        [_contenScroll addSubview:feile];
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
