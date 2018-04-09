//
//  UIRootView.h
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIRootItem;

@protocol UIRootViewDelegate <NSObject>

- (void)itemDidSelectedFrom:(UIRootItem *)fromItem toItem:(UIRootItem *)toItem;

@end

@interface UIRootView : UIView

@property (nonatomic, strong, readonly) NSArray <UIRootItem *>*items;

@property (nonatomic, strong, readonly) UIRootItem *currentItem;

@property (nonatomic, weak) id <UIRootViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray <UIRootItem *>*)items;

- (void)itemDidSelectedWith:(UIRootItem *)item;

@end
