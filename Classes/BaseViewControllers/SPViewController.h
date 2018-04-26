//
//  SPViewController.h
//  Project_Dms
//
//  Created by 超级腕电商 on 16/11/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import <UIKit/UIKit.h>
static const int kNaviStackMax = 99;

@protocol SPViewControllerDelegate <NSObject>
@optional
- (void)loadData;
- (void)reloadData;
@end
@interface SPViewController : UIViewController
@property(nonatomic, weak) id<SPViewControllerDelegate> viewDelegate;
@property(nonatomic) int naviBackIndex;


- (void)setupBackBarButtonItem;
// 关闭输入框
- (void)_handleEndEditing;
// 页面返回事件
- (void)_handleViewBack;
// 从导航栏栈中获取UIViewController
- (UIViewController *)viewControllerWithNaviIndex:(int)naviIndex;

// 交给子类去实现
- (void)loadData;
- (void)reloadData;

@end
