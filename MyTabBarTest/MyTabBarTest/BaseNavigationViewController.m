//
//  BaseNavigationViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/9.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController
@synthesize interactivePop = _interactivePop;


- (void)dealloc
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self preferredStatusBarStyle];
    self.interactivePop = YES;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popToViewControllerWithName:(NSString*)clsName animated:(BOOL)animated
{
    NSArray* array = [self viewControllers];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController* controller = (UIViewController*)obj;
        if ([controller isKindOfClass:NSClassFromString(clsName)]) {
            [self popToViewController:controller animated:YES];
            *stop = YES;
        }
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //NSLog(@"navigationController will push %@", [viewController class]);
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
        // 增加以下代码，解决某些情况下push时的假死bug
        // 原因是手势pop的问题。当处在navi的根控制器时候，做一个侧滑pop的操作，看起来没任何变化，但是再次push其它控制器时候，就会出现这个问题了。
        if (navigationController.viewControllers.count == 1) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (id<UIViewControllerAnimatedTransitioning> )navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        NSLog(@"navigationController will push to %@", [toVC class]);
    }else if(operation == UINavigationControllerOperationPop){
        NSLog(@"navigationController will pop to %@", [toVC class]);
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.viewControllers.count > 0)
    {
        if (self.topViewController != self.viewControllers[0])
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - getter & setter
-(void)setInteractivePop:(BOOL)interactivePop
{
    _interactivePop = interactivePop;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    gestureRecognizer.enabled = _interactivePop;
    return _interactivePop;
}

@end
