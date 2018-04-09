//
//  OneViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/9.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "OneViewController.h"
#import "OnePushViewController.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    self.navTitle = @"OneViewController";
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    OnePushViewController *push = [[OnePushViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

@end
