//
//  UIRootViewController.h
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "BaseViewController.h"

@interface UIRootViewController : BaseViewController

+ (instancetype)sharedRoot;

- (void)selectedtoIndex:(NSUInteger)toIndex;

- (void)hideTabBar:(BOOL)hide animated:(BOOL)animation;

@end
