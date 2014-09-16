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

import Foundation

private enum SideViewState {
    case Hidden
    case Showing
}

public class RootViewController : UIViewController {

    
    private var navigator : JBReplaceableRootNavigationController!
    private var mainContentViewContainer : UIView!
    private var sideViewState : SideViewState!
    private var assembly : ApplicationAssembly!

    private var citiesListController : UIViewController
    private var addCitiesController : UIViewController
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Initialization & Destruction
    //-------------------------------------------------------------------------------------------
    
    public init(mainContentViewController : UIViewController, assembly : ApplicationAssembly) {
        super.init(nibName : nil, bundle : nil)
        
        self.assembly = assembly
        self.sideViewState = SideViewState.Hidden
        self.pushViewController(mainContentViewController, replaceRoot: true)
    }
        
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //-------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    //-------------------------------------------------------------------------------------------

    public func pushViewController(controller : UIViewController) {
        self.pushViewController(controller, replaceRoot: false)
    }
    
    public func pushViewController(controller : UIViewController, replaceRoot : Bool) {
        
        let lockQueue = dispatch_queue_create("com.test.LockQueue", nil)
        dispatch_sync(lockQueue) {
            
            if (self.navigator == nil) {
                self.makeNavigationControllerWithRoot(controller)

            }
            
            

            
        }

        
    }

    

    
    - (void)pushViewController:(UIViewController *)viewController replaceRoot:(BOOL)replaceRoot
    {
    @synchronized (self)
    {
    if (!_navigator)
    {
    [self makeNavigationControllerWithRoot:viewController];
    }
    else if (replaceRoot)
    {
    [_navigator setRootViewController:viewController animated:YES];
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
    [[UINavigationController alloc] initWithRootViewController:[_assembly citiesListController]];
    
    [_citiesListController.view setFrame:CGRectMake(0, 0,
    _mainContentViewContainer.width - (_mainContentViewContainer.width - SIDE_CONTROLLER_WIDTH), _mainContentViewContainer.height)];
    
    PaperFoldView *view = (PaperFoldView *) self.view;
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
    PaperFoldView *view = (PaperFoldView *) self.view;
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
    
    
    - (void)showAddCitiesController
    {
    if (!_addCitiesController)
    {
    [_navigator.topViewController.view setUserInteractionEnabled:NO];
    _addCitiesController =
    [[UINavigationController alloc] initWithRootViewController:[_assembly addCityViewController]];
    
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

    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------

    private func makeNavigationControllerWithRoot(root : UIViewController) {
        self.navigator = JBReplaceableRootNavigationController(rootViewController: root)
    }
    
    
}