//
//  SAWDropDownAction.h
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^actionBlock)();

@interface DKDropDownAction : NSObject
@property (nonatomic, copy) actionBlock handlerBlock;
@property (nonatomic, strong) NSString *title;
+ (instancetype)actionWithTitle:(NSString*)title andAction:(actionBlock)completionHandler;
@end
