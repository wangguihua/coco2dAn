//
//  MBTabBarController.h
//  BOCMBCI
//
//  Created by Tracy E on 13-3-25.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OneViewController;
@class TwoViewController;
@class ThreeViewController;
@class FourViewController;
@class FiveViewController;



@interface MBTabBarController : UITabBarController<UIAlertViewDelegate>

@property (nonatomic ,unsafe_unretained) NSInteger itemIndex;

@property (nonatomic, strong) OneViewController *oneVC;
@property (nonatomic, strong) TwoViewController *twoVC;
@property (nonatomic, strong) ThreeViewController *threeVC;
@property (nonatomic, strong) FourViewController *fourVC;
@property (nonatomic, strong) FiveViewController *fiveVC;



@end
