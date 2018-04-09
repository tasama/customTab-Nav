//
//  UIRootItem.h
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIRootItem;
@protocol UIRootItemDelegate <NSObject>

- (void)itemDidSelectedWith:(UIRootItem *)item;

@end

@interface UIRootItem : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, weak) id <UIRootItemDelegate> delegate;

@end
