//
//  SAWDropDownViewController.m
//  dropDownMenu
//
//  Created by Dmitriy Kovryhin on 11/6/15.
//  Copyright © 2015 Dmitriy Kovryhin. All rights reserved.
//

#import "DKDropDownViewController.h"
#import "DKDropDownTableViewCell.h"

#define CELL_HEIGHT 50
#define MINIMUM_WIDTH 150

@interface DKDropDownViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *actions;
@property (nonatomic, weak)IBOutlet UITableView *tableView;
@property (nonatomic, weak)IBOutlet UIView *pseudoBackground;
@property (nonatomic, weak)IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, weak)IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
@property (nonatomic, weak)IBOutlet NSLayoutConstraint *tableViewLeadingConstraint;
@property (nonatomic, weak)IBOutlet NSLayoutConstraint *tableViewTrailingConstraint;
@end

@implementation DKDropDownViewController
static DKDropDownViewController *instance;
- (instancetype)init
{
    NSBundle *bundle = [NSBundle bundleForClass:self.classForCoder];
    self = [[UIStoryboard storyboardWithName:@"DropDownMenu" bundle:bundle] instantiateInitialViewController];
    if (self)
    {
        self.actions = [NSMutableArray new];
    }
    instance = self;
    return self;
}

- (void)presentFromView:(UIView*)view
{
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
    [self presentFromRect:rect];
}

- (void)presentFromRect:(CGRect)rect
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = @{@"view":self.view};
    [[UIApplication sharedApplication].keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [[UIApplication sharedApplication].keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsDictionary]];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.tableView];
    self.originRect = rect;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)hideMenu
{
    [self.view removeFromSuperview];
    instance = nil;
}

- (BOOL)goesDown
{
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat origY = MAX(self.originRect.origin.y, 22);
    return origY + self.actions.count * CELL_HEIGHT < screen.height;
}

- (BOOL)goesDownIfFrom:(CGRect)rect
{
    self.originRect = rect;
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat origY = MAX(rect.origin.y, 22);
    return origY + self.actions.count * CELL_HEIGHT < screen.height;
}

- (BOOL)goesRight
{
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat width = MAX(self.originRect.size.width, MINIMUM_WIDTH);
    return self.originRect.origin.x + width < screen.width;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat width = MAX(self.originRect.size.width, MINIMUM_WIDTH);
    CGFloat origY = MAX(self.originRect.origin.y, 22);
    if ([self goesRight])
    {
        //right
        self.tableViewLeadingConstraint.constant = self.originRect.origin.x;
        self.tableViewTrailingConstraint.constant = screen.width - self.originRect.origin.x - width;
    }
    else
    {
        //left
        self.tableViewLeadingConstraint.constant = self.originRect.origin.x + self.originRect.size.width - width;
        self.tableViewTrailingConstraint.constant = screen.width - self.originRect.origin.x - self.originRect.size.width;
    }
    
    {
        //up
        self.tableViewBottomConstraint.constant = [UIScreen mainScreen].bounds.size.height - origY - self.originRect.size.height;
    }

    
    self.tableViewHeightConstraint.constant = self.originRect.size.height;

    [self.view layoutIfNeeded];
    self.tableView.alpha = 0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        if (!_forceUp && ([self goesDown] || _forceDown))
        {
            //down
            self.tableViewBottomConstraint.constant = [UIScreen mainScreen].bounds.size.height - origY - self.actions.count * CELL_HEIGHT;
        }
        self.tableViewHeightConstraint.constant = self.actions.count * CELL_HEIGHT;
        self.pseudoBackground.alpha = 0.7;
        self.tableView.alpha = 1.0f;
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)];
    [self.pseudoBackground addGestureRecognizer:tgr];
    self.pseudoBackground.userInteractionEnabled = YES;
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.shadowView.layer.shadowOpacity = 0.8f;
    self.tableView.backgroundColor = self.backgroundColor;
    self.tableView.clipsToBounds = YES;
    self.shadowView.backgroundColor = self.tableView.backgroundColor;
}

#pragma mark - Add actions

- (void)addActionWithTitle:(NSString *)title handler:(actionBlock)actionBlock
{
    if (!actionBlock) {
        actionBlock = ^{};
    }
    [self addAction:[DKDropDownAction actionWithTitle:title andAction:actionBlock]];
}

- (void)addAction:(DKDropDownAction *)action
{
    [self.actions addObject:action];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKDropDownAction *action = self.actions[indexPath.row];
    DKDropDownTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[DKDropDownTableViewCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.action = action;
    [cell configureWithOwnedAction];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKDropDownAction *action = self.actions[indexPath.row];
    [self hideMenu];
    action.handlerBlock();
}
@end
