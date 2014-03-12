//
//  MBTabBarController.m
//  BOCMBCI
//
//  Created by Tracy E on 13-3-25.
//  Copyright (c) 2013年 China M-World Co.,Ltd. All rights reserved.
//

#import "MBTabBarController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "MBGlobalUICommon.h"
#import "MBLabel.h"
#import "MBPopMenu.h"
#import "MBConstant.h"
@interface UITabBar (CustomStyle)
@end

@implementation UITabBar (CustomStyle)

- (void)drawRect:(CGRect)rect
{
    if (MBOSVersion() < 5.0) {
        UIImage *image;
        image = [UIImage imageNamed:@"tabBarBG.png"];
        [image drawInRect:CGRectMake(0, self.bounds.size.height - image.size.height,
                                     self.bounds.size.width, image.size.height)];
    }
}
@end

//--------------------------------------------------------------------------------------------------
//TabBar上的快捷菜单Item
@interface MBShortcutButton : UIImageView
@property (nonatomic, strong) MBLabel *textLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *url;
+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image url:(NSString *)url;
@end

@implementation MBShortcutButton

+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image url:(NSString *)url{
    return [[MBShortcutButton alloc] initWithTitle:title image:image url:url];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image url:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
        
        self.image = [UIImage imageNamed:@"submenu_bg.png"];
        self.userInteractionEnabled = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 30, 30)];
        [self addSubview:_imageView];
        
        if (!image) {
            _imageView.image = [UIImage imageNamed:@"submenu_add.png"];
        } else {
            _imageView.image = image;
        }
        
        _textLabel = [[MBLabel alloc] initWithFrame:CGRectMake(0, 45, 52, 20)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont boldSystemFontOfSize:10];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.text = title;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.isPaoMaDeng = YES;
        [self addSubview:_textLabel];
    }
    return self;
}
@end


//--------------------------------------------------------------------------------------------------
@interface MBTabBarController (){
    BOOL                    _isActionAnimating;
    
    NSArray *               _menuList;
    UIButton *              _menuBackButton;
    UILabel *               _menuTipLabel;
    
    UIImageView *           _defaultView;
    NSString *              _appStoreURL;
    

    UIControl *             _shortcutBackgroundView;
    UIImageView *           _menuBG;
    BOOL                    _isMenuShow;
    
}

@end

@implementation MBTabBarController

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
	// Do any additional setup after loading the view.
    
    
    _oneVC =[[OneViewController alloc]init];
    _twoVC =[[TwoViewController alloc]init];
    _threeVC =[[ThreeViewController alloc]init];
    _fourVC =[[FourViewController alloc]init];
    _fiveVC =[[FiveViewController alloc]init];

   
    self.tabBar.clipsToBounds=YES;
    if (MBOSVersion() >= 6.0)
    {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    }

    
    UINavigationController *oneNav =
    [[UINavigationController alloc] initWithRootViewController:_oneVC];
    
    oneNav.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"名录"
                                  image:[UIImage imageNamed:@"tabBarItem1.png"]
                                    tag:0];
    oneNav.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBarItem1_red.png"];//4.3下可以使用

    UINavigationController *twoNav =
    [[UINavigationController alloc] initWithRootViewController:_twoVC];
    
    twoNav.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"记事"
                                  image:[UIImage imageNamed:@"tabBarItem2.png"]
                                    tag:0];
    twoNav.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBarItem2_red.png"];//4.3下可以使用
    
   
//    UINavigationController *threeNav =
//    [[UINavigationController alloc] initWithRootViewController:_threeVC];
//    
//    threeNav.tabBarItem =
//    [[UITabBarItem alloc] initWithTitle:@"活动"
//                                  image:[UIImage imageNamed:@"tabBarItem0.png"]
//                                    tag:0];
//    threeNav.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBarItem0_red.png"];//4.3下可以使用
//    

    UINavigationController *fourNav =
    [[UINavigationController alloc] initWithRootViewController:_fourVC];
    
    fourNav.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"二维码"
                                  image:[UIImage imageNamed:@"tabBarItem3.png"]
                                    tag:0];
    fourNav.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBarItem3_red.png"];//4.3下可以使用
    

    UINavigationController *fiveNav =
    [[UINavigationController alloc] initWithRootViewController:_fiveVC];
    
    fiveNav.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"拍照"
                                  image:[UIImage imageNamed:@"tabBarItem4.png"]
                                    tag:0];
    fiveNav.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBarItem4_red.png"];//4.3下可以使用
    

    
    self.viewControllers = @[oneNav,
                             twoNav,
//                             threeNav,
                             fourNav,
                             fiveNav];
   
    [self configAppearance];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
- (BOOL)shouldAutorotate{
    return NO;
}


#pragma mark - Custom Methods
//配置程序外观（StatusBar | NavigationBar | TabBar）
- (void)configAppearance{
    
    if (MBOSVersion()>=7) {
        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBG.png"];
    } else if (MBOSVersion() >= 5.0) {
        [[UINavigationBar appearance] setTintColor:MB_RGB(160, 0, 0)];
        [[[UINavigationBar class] appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"]
                                                   forBarMetrics:UIBarMetricsDefault];
        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBG.png"];
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tabBarSelectedImage.png"];
        self.tabBar.selectedImageTintColor = [UIColor whiteColor];
    }
}

#pragma mark - UITabBarDelegate Method
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if ([item.title isEqualToString:@"名录"]) {
        
        NSMutableArray *items=[[NSMutableArray alloc] initWithCapacity:2];
        
        [items addObject: [MBPopMenuItem menuItem:@"商企名录" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"供求信息" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"人才招聘" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"商务活动" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"诚信投报" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"亿 商 会" image:nil target:self action:@selector(tranConnect:)]];

        [MBPopMenu showMenuInView:self.view fromRect:CGRectMake(20, kScreenHeight-49, 50, 40) menuItems:items];
        
    }
    if ([item.title isEqualToString:@"二维码"]) {
        
        NSMutableArray *items=[[NSMutableArray alloc] initWithCapacity:2];
        
        [items addObject: [MBPopMenuItem menuItem:@"扫描浏览" image:nil target:self action:@selector(tranConnect:)]];
        [items addObject: [MBPopMenuItem menuItem:@"产生维图" image:nil target:self action:@selector(tranConnect:)]];
        
        [MBPopMenu showMenuInView:self.view fromRect:CGRectMake(175, kScreenHeight-49, 50, 40) menuItems:items];
        
    }
    
    
}
-(void)tranConnect:(MBPopMenuItem*)item
{
    [_oneVC loadWebVIewWithWebViewItemStr:item.title];
}


@end
