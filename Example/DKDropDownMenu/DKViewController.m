//
//  DKViewController.m
//  DKDropDownMenu
//
//  Created by Dmytro Kovryhin on 11/30/2016.
//  Copyright (c) 2016 Dmytro Kovryhin. All rights reserved.
//

#import "DKViewController.h"
#import "DKDropDownMenu/DKDropDownViewController.h"

@interface DKViewController ()

@end

@implementation DKViewController

- (IBAction)showMenuFromButton:(UIButton*)sender
{
    [[self menuExample] presentFromView:sender];
}

- (DKDropDownViewController*)menuExample
{
    DKDropDownViewController *menu = [DKDropDownViewController new];
    menu.backgroundColor = [UIColor lightGrayColor];
    [menu addAction:[self actionAtIndex:0]];
    [menu addAction:[self actionAtIndex:1]];
    [menu addAction:[self actionAtIndex:2]];
    return menu;
}

- (DKDropDownAction*)actionAtIndex:(NSInteger)idx
{
    NSString *title = [NSString stringWithFormat:@"Option %ld", idx];
    return [DKDropDownAction actionWithTitle:title andAction:^{
        [self showAlertWithMessage:[title stringByAppendingString:@" selected"]];
    }];
}

- (void)showAlertWithMessage:(NSString*)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
