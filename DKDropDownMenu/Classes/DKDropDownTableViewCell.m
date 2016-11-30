//
//  SAWDropDownTableViewCell.m
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import "DKDropDownTableViewCell.h"

@interface DKDropDownTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *titleTextLabel;
@end

@implementation DKDropDownTableViewCell

+ (NSString*)cellReuseIdentifier
{
    return @"DKDropDownTableViewCellReuse";
}

- (void)configureWithOwnedAction
{
    self.titleTextLabel.text = self.action.title;
}

@end
