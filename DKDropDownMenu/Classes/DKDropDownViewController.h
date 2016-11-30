//
//  SAWDropDownViewController.h
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKDropDownAction.h"

@interface DKDropDownViewController : UIViewController
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) BOOL forceDown;
@property (nonatomic, assign) BOOL forceUp;
- (void)addActionWithTitle:(NSString*)title handler:(actionBlock)actionBlock;
- (void)addAction:(DKDropDownAction*)action;
- (void)presentFromRect:(CGRect)rect;
- (void)presentFromView:(UIView*)view;
- (BOOL)goesDownIfFrom:(CGRect)rect;
- (BOOL)goesRight;
@end
