//
//  OneViewController.h
//  Demo
//
//  Created by llbt_wgh on 14-3-5.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController
@property(nonatomic,copy)NSString *contenStr;
@property (weak, nonatomic) IBOutlet UILabel *wordWeh;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *content;

@end
