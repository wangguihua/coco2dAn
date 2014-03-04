//
//  MBMainViewController.h
//  Demo
//
//  Created by llbt_wgh on 14-3-4.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSelectView.h"
@interface MBMainViewController : UIViewController
{
    MBSelectView *_nieBuSel;
    MBSelectView *_linDaSel;
    MBSelectView *_persoSel;

}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *wordWhere;
@property (weak, nonatomic) IBOutlet UILabel *kezhang;
@property (weak, nonatomic) IBOutlet UILabel *job;

- (IBAction)oneBtnPressed:(id)sender;
- (IBAction)twoBtnPressed:(id)sender;
- (IBAction)thrBtnPressed:(id)sender;
- (IBAction)fouBtnPressed:(id)sender;
- (IBAction)fivBtnPressed:(id)sender;
- (IBAction)sixBtnPressed:(id)sender;
- (IBAction)sevBtnPressed:(id)sender;

- (IBAction)searchBtnPressed:(id)sender;

@end
