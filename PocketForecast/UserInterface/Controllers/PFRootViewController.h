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


#import <UIKit/UIKit.h>
#import "PaperFoldView.h"

@class PFProgressHUD;
@class PFAssembly;
@class TyphoonComponentFactory;


typedef enum
{
    PFSideViewStateHidden,
    PFSideViewStateShowing
} PFSideViewState;

@interface PFRootViewController : UIViewController <PaperFoldViewDelegate>
{
    UINavigationController* _navigator;
    UIView* _mainContentViewContainer;
    UIView* _slideOnMainContentViewContainer;
    PFSideViewState _sideViewState;
    NSInteger _progressHudRetainCount;

    UIViewController* _citiesListController;
    UIViewController* _addCitiesController;

    TyphoonComponentFactory* _factory;
}

@property(nonatomic, strong, readonly) PFProgressHUD* progressHUD;

/**
* Creates a root view controller instance, with the initial main content view controller, and side view controller.
*/
- (instancetype)initWithMainContentViewController:(UIViewController*)mainContentViewController;

/**
* Sets main content view, with an animated transition.
*/
- (void)pushViewController:(UIViewController*)viewController;

- (void)pushViewController:(UIViewController*)viewController replaceRoot:(BOOL)replaceRoot;

- (void)popViewControllerAnimated:(BOOL)animated;

/**
* Shows the cities list menu. We could have injected this component, however we'll instead load from the TyphoonComponentFactory on-demand,
* and release the prototype-scoped instance when done. .
*/
- (void)showCitiesListController;

- (void)dismissCitiesListController;

- (void)showAddCitiesController;

- (void)dismissAddCitiesController;

- (void)toggleSideViewController;

- (void)showProgressHUD;

- (void)dismissProgressHUD;


@end
