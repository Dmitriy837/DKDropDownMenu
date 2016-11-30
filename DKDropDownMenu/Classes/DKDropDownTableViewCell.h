//
//  SAWDropDownTableViewCell.h
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKDropDownAction.h"

@interface DKDropDownTableViewCell : UITableViewCell
@property (nonatomic, weak) DKDropDownAction *action;
- (void)configureWithOwnedAction;
+ (NSString*)cellReuseIdentifier;
@end
