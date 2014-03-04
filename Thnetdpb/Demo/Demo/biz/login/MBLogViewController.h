//
//  MBLogViewController.h
//  Demo
//
//  Created by llbt_wgh on 14-3-4.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTextField.h"
@interface MBLogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *countName;
@property (weak, nonatomic) IBOutlet UITextField *pad;
- (IBAction)logBtnPressed:(id)sender;

@end
