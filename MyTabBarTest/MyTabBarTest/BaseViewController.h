//
//  BaseViewController.h
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSString *navTitle;

@property (nonatomic, strong, readonly) UIImageView *navigationBar;

- (void)hideNav:(BOOL)hide withAnimation:(BOOL)animation;

@end
