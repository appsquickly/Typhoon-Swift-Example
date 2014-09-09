////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import "CKUITools.h"
#import "PFRootViewController.h"
#import "PFProgressHUD.h"
#import "TyphoonComponentFactory.h"
#import "PFCitiesListViewController.h"
#import "PFAddCityViewController.h"

#define SIDE_CONTROLLER_WIDTH 245.0

@implementation PFRootViewController

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (instancetype)initWithMainContentViewController:(UIViewController*)mainContentViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _sideViewState = PFSideViewStateHidden;
        if (mainContentViewController)
        {
            [self pushViewController:mainContentViewController replaceRoot:YES];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithMainContentViewController:nil];
}

- (void)typhoonWillInject
{
    if (self.view)
    {} //Eager load view
}

/**
* Since we have a PFAssembly interface (from the block-style assembly) we'll place that interface as a facade in front of the
* TyphoonComponentFactory. . . we could also use the TyphoonComponentFactory interface directly, eg:
 *
 *      TyphoonComponentFactory* factory = theFactory;
*/
- (void)typhoonSetFactory:(id)theFactory
{
    _factory = theFactory;
}


/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)pushViewController:(UIViewController*)viewController
{
    [self pushViewController:viewController replaceRoot:NO];
}

- (void)pushViewController:(UIViewController*)viewController replaceRoot:(BOOL)replaceRoot
{
    @synchronized (self)
    {
        if (replaceRoot || _navigator == nil)
        {
            BOOL isApplicationStartup = _navigator == nil ? YES : NO;

            [self makeNavigationControllerWithRoot:viewController];
            if (!isApplicationStartup)
            {
                [self performPushAnimation];
            }
            else
            {
                [_navigator.view setFrame:_mainContentViewContainer.bounds];
                [_mainContentViewContainer addSubview:_navigator.view];
            }
        }
        else
        {
            [_navigator pushViewController:viewController animated:YES];
        }
    }
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    @synchronized (self)
    {
        [_navigator popViewControllerAnimated:animated];
    }
}

- (void)showCitiesListController
{
    if (_sideViewState != PFSideViewStateShowing)
    {
        _sideViewState = PFSideViewStateShowing;

        _citiesListController =
            [[UINavigationController alloc] initWithRootViewController:[_factory componentForType:[PFCitiesListViewController class]]];

        [_citiesListController.view setFrame:CGRectMake(0, 0,
            _mainContentViewContainer.width - (_mainContentViewContainer.width - SIDE_CONTROLLER_WIDTH), _mainContentViewContainer.height)];

        PaperFoldView* view = (PaperFoldView*) self.view;
        [view setDelegate:self];
        [view setLeftFoldContentView:_citiesListController.view foldCount:5 pullFactor:0.9];
        [view setEnableLeftFoldDragging:NO];
        [view setEnableRightFoldDragging:NO];
        [view setEnableTopFoldDragging:NO];
        [view setEnableBottomFoldDragging:NO];
        [view setEnableHorizontalEdgeDragging:NO];
        [view setPaperFoldState:PaperFoldStateLeftUnfolded];

        [_mainContentViewContainer setNeedsDisplay];
    }
}

- (void)dismissCitiesListController
{
    if (_sideViewState != PFSideViewStateHidden)
    {
        _sideViewState = PFSideViewStateHidden;
        PaperFoldView* view = (PaperFoldView*) self.view;
        [view setPaperFoldState:PaperFoldStateDefault];
        [_navigator.topViewController viewWillAppear:YES];
    }
}

- (void)toggleSideViewController
{
    if (_sideViewState == PFSideViewStateHidden)
    {
        [self showCitiesListController];
    }
    else if (_sideViewState == PFSideViewStateShowing)
    {
        [self dismissCitiesListController];
    }
}


- (void)showProgressHUD
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        if (_progressHudRetainCount == 0)
        {
            _progressHUD = [[PFProgressHUD alloc] initWithFrame:self.view.frame];
            [_progressHUD setAlpha:0];
            [self.view setUserInteractionEnabled:NO];
            [UIView transitionWithView:_progressHUD duration:0.33 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^
            {
                [self.view addSubview:_progressHUD];
                [_progressHUD setAlpha:1.0];
            } completion:nil];
        }
        _progressHudRetainCount++;
    });
}

- (void)dismissProgressHUD
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        _progressHudRetainCount--;
        if (_progressHudRetainCount == 0)
        {
            [UIView transitionWithView:_progressHUD duration:0.25 options:UIViewAnimationOptionTransitionFlipFromTop animations:^
            {
                [_progressHUD setAlpha:0.0];
            } completion:^(BOOL finished)
            {
                [_progressHUD removeFromSuperview];
                _progressHUD = nil;
                [self.view setUserInteractionEnabled:YES];
            }];
        }
        if (_progressHudRetainCount < 0)
        {
            _progressHudRetainCount = 0;
            LogError("*** Unmatched calls to progressHUD present/dismiss ***");
        }

    });
}

- (void)showAddCitiesController
{
    if (!_addCitiesController)
    {
        [_navigator.topViewController.view setUserInteractionEnabled:NO];
        _addCitiesController =
            [[UINavigationController alloc] initWithRootViewController:[_factory componentForType:[PFAddCityViewController class]]];

        [_addCitiesController.view setFrame:CGRectMake(0, self.view.height, SIDE_CONTROLLER_WIDTH, self.view.height)];
        [self.view addSubview:_addCitiesController.view];

        __block CGRect frame = _citiesListController.view.frame;
        [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            frame.origin.y = 0;
            _addCitiesController.view.frame = frame;
        } completion:nil];
    }
}

- (void)dismissAddCitiesController
{
    if (_addCitiesController)
    {
        [_citiesListController viewWillAppear:YES];
        __block CGRect frame = _citiesListController.view.frame;
        [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            frame.origin.y += self.view.height;
            _addCitiesController.view.frame = frame;
        } completion:^(BOOL finished)
        {
            [_addCitiesController.view removeFromSuperview];
            _addCitiesController = nil;
            [_citiesListController viewDidAppear:YES];
            [_navigator.topViewController.view setUserInteractionEnabled:YES];
        }];
    }
}

/* ====================================================================================================================================== */
#pragma mark - Protocol Methods

- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    if (paperFoldState == PaperFoldStateDefault)
    {
        [_navigator.topViewController viewDidAppear:YES];

        //We could set the left-side view to nil here, however Paper-fold issues a (basically harmless) warning about CGRectZero state.
        UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
        [(PaperFoldView*) self.view setLeftFoldContentView:dummyView foldCount:0 pullFactor:0];
        _citiesListController = nil;
    }
}


/* ====================================================================================================================================== */
#pragma mark - Override

- (void)loadView
{
    CGRect screen = [UIScreen mainScreen].bounds;

    PaperFoldView* paperFoldView;

    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7)
    {
        paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    }
    else
    {
        paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width,
            screen.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    }
    [paperFoldView setTimerStepDuration:0.02];
    self.view = paperFoldView;

    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    _mainContentViewContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    [_mainContentViewContainer setBackgroundColor:[UIColor blackColor]];
    [paperFoldView setCenterContentView:_mainContentViewContainer];

    _slideOnMainContentViewContainer = [[UIView alloc] initWithFrame:_mainContentViewContainer.bounds];
    [_slideOnMainContentViewContainer setHidden:YES];
    [self.view addSubview:_slideOnMainContentViewContainer];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_mainContentViewContainer setFrame:self.view.bounds];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController* topController = _navigator.topViewController;
    return [topController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    UIViewController* topController = _navigator.topViewController;
    return [topController shouldAutorotate];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_navigator.topViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_navigator.topViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)makeNavigationControllerWithRoot:(UIViewController*)root
{
    _navigator = [[UINavigationController alloc] initWithRootViewController:root];
    _navigator.view.frame = self.view.bounds;
}

- (void)performPushAnimation
{
    CGFloat slideOnInitialX = _mainContentViewContainer.frame.size.width;
    _slideOnMainContentViewContainer.frame =
        CGRectMake(slideOnInitialX, 0, _mainContentViewContainer.frame.size.width, _mainContentViewContainer.frame.size.height);
    _mainContentViewContainer.frame =
        CGRectMake(0, 0, _mainContentViewContainer.frame.size.width, _mainContentViewContainer.frame.size.height);
    [_slideOnMainContentViewContainer addSubview:_navigator.view];
    [_slideOnMainContentViewContainer setHidden:NO];

    CGRect mainContentViewFrame = _mainContentViewContainer.frame;
    mainContentViewFrame.origin.x -= slideOnInitialX;
    CGRect slideOnViewFrame = _slideOnMainContentViewContainer.frame;
    slideOnViewFrame.origin.x -= slideOnInitialX;

    [UIView transitionWithView:_mainContentViewContainer duration:0.40 options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
        _mainContentViewContainer.frame = mainContentViewFrame;
        _slideOnMainContentViewContainer.frame = slideOnViewFrame;
    } completion:^(BOOL complete)
    {
        [_navigator.view removeFromSuperview];
        [_navigator.view setFrame:_mainContentViewContainer.bounds];
        [_mainContentViewContainer addSubview:_navigator.view];
        [_mainContentViewContainer setFrame:self.view.bounds];
        [_slideOnMainContentViewContainer setHidden:YES];
    }];
}

@end
