//
//  FiveViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/9.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "FiveViewController.h"
#import "UIRootViewController.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor purpleColor];
    [self hideNav:YES withAnimation:NO];
    self.navTitle = NSStringFromClass(self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIRootViewController *root = [UIRootViewController sharedRoot];
    [root selectedtoIndex:3];
}

@end
