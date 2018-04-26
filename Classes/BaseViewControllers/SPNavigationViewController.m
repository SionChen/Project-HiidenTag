//
//  SPNavigationViewController.m
//  Project_Dms
//
//  Created by 超级腕电商 on 16/11/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "SPNavigationViewController.h"

@interface SPNavigationViewController ()

@end

@implementation SPNavigationViewController

- (void)dealloc {
    DBLOG(@"[%@ dealloc]", [self class]);
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_fullscreenPopGestureRecognizer.enabled = true;
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = true;
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = false;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    self.navigationBar.layer.shadowOpacity = 0.4;
    self.navigationBar.layer.shadowRadius = 6;
    self.navigationBar.layer.shadowColor = [UIColor colorWithHexString:@"d0c5d9"].CGColor;
    self.navigationBar.layer.shouldRasterize=YES;
    self.navigationBar.layer.rasterizationScale=[UIScreen mainScreen].scale;
    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#3c3146 "]};
    [self.navigationBar setTitleTextAttributes:titleTextAttributes];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
