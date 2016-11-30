//
//  SAWDropDownAction.m
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import "DKDropDownAction.h"

@implementation DKDropDownAction
+ (instancetype)actionWithTitle:(NSString*)title andAction:(actionBlock)completionHandler
{
    DKDropDownAction *action = [DKDropDownAction new];
    action.title = title;
    action.handlerBlock = completionHandler;
    return action;
}
@end
