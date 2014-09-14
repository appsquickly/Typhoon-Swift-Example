////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import "JBReplaceableRootNavigationController.h"


@implementation JBReplaceableRootNavigationController

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

//override the standard init
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    //create the fake controller and set it as the root
    UIViewController *fakeController = [[UIViewController alloc] init];
    if (self = [super initWithRootViewController:fakeController])
    {
        _fakeRootViewController = fakeController;
        //hide the back button on the perceived root
        rootViewController.navigationItem.hidesBackButton = YES;
        //push the perceived root (at index 1)
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

//this is the new method that lets you set the perceived root, the previous one will be popped (released)
- (void)setRootViewController:(UIViewController *)rootViewController animated:(BOOL)animated
{
    rootViewController.navigationItem.hidesBackButton = YES;
    [self popToViewController:_fakeRootViewController animated:NO];
    [self pushViewController:rootViewController animated:animated];
}


/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

//override to remove fake root controller
- (NSArray *)viewControllers
{
    NSArray *viewControllers = [super viewControllers];
    if (viewControllers != nil && viewControllers.count > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithArray:viewControllers];
        [array removeObjectAtIndex:0];
        return array;
    }
    return viewControllers;
}

//override so it pops to the perceived root
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    //we use index 0 because we overridden “viewControllers”
    return [self popToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}

@end
