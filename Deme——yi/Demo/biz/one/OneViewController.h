//
//  OneViewController.h
//  Demo
//
//  Created by llbt_wgh on 14-3-10.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController
@property(nonatomic,strong)UIWebView *loadWebView;
-(void)loadWebVIewWithWebViewItemStr:(NSString *)str;
@end
