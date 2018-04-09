//
//  FourViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/9.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navTitle = NSStringFromClass(self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

@end
