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

public class RootViewController : UIViewController, PaperFoldViewDelegate {

    let SIDE_CONTROLLER_WIDTH : CGFloat = 245.0
    let lockQueue = dispatch_queue_create("pf.root.lockQueue", nil)
    
    private var navigator : UINavigationController!
    private var mainContentViewContainer : UIView!
    private var sideViewState : SideViewState!
    private var assembly : ApplicationAssembly!
    
    private var paperFoldView : PaperFoldView {
        get {
            return self.view as PaperFoldView
        }
        set {
            self.view = newValue
        }
    }

    private var citiesListController : UIViewController?
    private var addCitiesController : UIViewController?
    
    
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
        
        dispatch_sync(lockQueue) {
            
            if (self.navigator == nil) {
                self.makeNavigationControllerWithRoot(controller)
            }
            else if (replaceRoot) {
                self.navigator.setViewControllers([controller], animated: true)
            }
            else {
                self.navigator.pushViewController(controller, animated: true)
            }
        }
    }

    public func popViewControllerAnimated(animated : Bool) {
        
        let lockQueue = dispatch_queue_create("pf.root.lockQueue", nil)
        dispatch_sync(lockQueue) {
            self.navigator.popViewControllerAnimated(animated)
            return
        }
    }
    
    public func showCitiesListController() {
        if (self.sideViewState != SideViewState.Showing) {
            self.sideViewState = SideViewState.Showing
            self.citiesListController = UINavigationController(rootViewController: self.assembly.citiesListController() as UIViewController)
            
            self.citiesListController!.view.frame = CGRectMake(0, 0, SIDE_CONTROLLER_WIDTH, self.mainContentViewContainer.frame.size.height)
            
            self.paperFoldView.delegate = self
            self.paperFoldView.setLeftFoldContentView(citiesListController!.view, foldCount: 5, pullFactor: 0.9)
            self.paperFoldView.setPaperFoldState(PaperFoldStateLeftUnfolded)
            self.mainContentViewContainer.setNeedsDisplay()
        }
    }
    
    public func dismissCitiesListController() {
        if (self.sideViewState != SideViewState.Hidden) {
            self.sideViewState = SideViewState.Hidden
            self.paperFoldView.setPaperFoldState(PaperFoldStateDefault)
            self.navigator!.topViewController.viewWillAppear(true)
        }
    }

    public func toggleSideViewController() {
        if (self.sideViewState == SideViewState.Hidden) {
            self.showCitiesListController()
        }
        else if (self.sideViewState == SideViewState.Showing) {
            self.dismissCitiesListController()
        }
    }
    
    public func showAddCitiesController() {
        if (self.addCitiesController == nil) {
            self.navigator.topViewController.view.userInteractionEnabled = false
            
            self.addCitiesController = UINavigationController(rootViewController: self.assembly.addCityViewController() as UIViewController)            
            
            self.addCitiesController!.view.frame = CGRectMake(0, self.view.frame.origin.y + self.view.frame.size.height, SIDE_CONTROLLER_WIDTH, self.view.frame.size.height)
            self.view.addSubview(self.addCitiesController!.view)
            
            UIView.transitionWithView(self.view, duration: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                
                self.addCitiesController!.view.frame = CGRectMake(0, 0, self.SIDE_CONTROLLER_WIDTH, self.view.frame.size.height)
                
            }, completion: nil)
        }
    }
    
    public func dismissAddCitiesController() {
        if (self.addCitiesController != nil) {
            self.citiesListController?.viewWillAppear(true)
            UIView.transitionWithView(self.view, duration: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                
                self.addCitiesController!.view.frame = CGRectMake(0, self.view.frame.size.height, self.SIDE_CONTROLLER_WIDTH, self.view.frame.size.height)
                
            }, completion: {
                (completed) in
                
                self.addCitiesController!.view.removeFromSuperview()
                self.addCitiesController = nil
                self.citiesListController?.viewDidAppear(true)
                self.navigator.topViewController.view.userInteractionEnabled = true
            })
        }
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - PaperFoldViewDelegate
    //-------------------------------------------------------------------------------------------

    public func paperFoldView(paperFoldView: AnyObject!, didFoldAutomatically automated: Bool, toState state: Int) {
        
        //TODO: Why does Swift think this is a SideViewState
        if (state == 0) {
            self.navigator.topViewController.viewDidAppear(true)
            

            let dummyView = UIView(frame: CGRectMake(1,1,1,1))
            self.paperFoldView.setLeftFoldContentView(dummyView, foldCount: 0, pullFactor: 0)
            self.citiesListController = nil
        }
        
    }

    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden Methods
    //-------------------------------------------------------------------------------------------

    public override func loadView() {
        let screen = UIScreen.mainScreen().bounds
        self.paperFoldView = PaperFoldView(frame: CGRectMake(0, 0, screen.size.width, screen.size.height))
        self.paperFoldView.timerStepDuration = 0.02
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        self.mainContentViewContainer = UIView(frame: self.paperFoldView.bounds)
        self.mainContentViewContainer.backgroundColor = UIColor.blackColor()
        self.paperFoldView.setCenterContentView(self.mainContentViewContainer)
    }
    
    public override func viewWillLayoutSubviews() {
        self.mainContentViewContainer.frame = self.view.bounds
    }
    
    public override func shouldAutorotate() -> Bool {
        return self.navigator!.topViewController.shouldAutorotate()
    }
    
    public override func willRotateToInterfaceOrientation(orientation: UIInterfaceOrientation, duration: NSTimeInterval) {

        self.navigator!.topViewController.willRotateToInterfaceOrientation(orientation, duration: duration)
    }
    
    public override func didRotateFromInterfaceOrientation(orientation: UIInterfaceOrientation) {
        self.navigator!.topViewController.didRotateFromInterfaceOrientation(orientation)
    }

            
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    //-------------------------------------------------------------------------------------------

    private func makeNavigationControllerWithRoot(root : UIViewController) {
        self.navigator = UINavigationController(rootViewController: root)
        self.navigator.view.frame = self.view.bounds
        mainContentViewContainer.addSubview(self.navigator.view)
    }
    
    
}