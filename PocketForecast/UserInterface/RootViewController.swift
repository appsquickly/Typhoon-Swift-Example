////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

private enum SideViewState {
    case hidden
    case showing
}

public class RootViewController : UIViewController, PaperFoldViewDelegate {

    let SIDE_CONTROLLER_WIDTH : CGFloat = 245.0
    let lockQueue = DispatchQueue(label: "pf.root.lockQueue")
    
    private var navigator : UINavigationController!
    private var mainContentViewContainer : UIView!
    private var sideViewState : SideViewState!
    private var assembly : ApplicationAssembly!
    
    private var paperFoldView : PaperFoldView {
        get {
            return self.view as! PaperFoldView
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
        self.sideViewState = .hidden
        self.pushViewController(controller: mainContentViewController, replaceRoot: true)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //-------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    //-------------------------------------------------------------------------------------------

    public func pushViewController(controller : UIViewController) {
        self.pushViewController(controller: controller, replaceRoot: false)
    }
    
    public func pushViewController(controller : UIViewController, replaceRoot : Bool) {
        
        lockQueue.sync() {
            
            if self.navigator == nil {
                self.makeNavigationControllerWithRoot(root: controller)
            }
            else if replaceRoot {
                self.navigator.setViewControllers([controller], animated: true)
            }
            else {
                self.navigator.pushViewController(controller, animated: true)
            }
        }
    }

    public func popViewControllerAnimated(animated : Bool) {
        
        let lockQueue = DispatchQueue(label: "pf.root.lockQueue")
        lockQueue.sync() {
            self.navigator.popViewController(animated: animated)
            return
        }
    }
    
    public func showCitiesListController() {
        if self.sideViewState != .showing {
            self.sideViewState = .showing
            self.citiesListController = UINavigationController(rootViewController: self.assembly.citiesListController() as! UIViewController)
            
            self.citiesListController!.view.frame = CGRect(x: 0, y: 0, width: SIDE_CONTROLLER_WIDTH, height: self.mainContentViewContainer.frame.size.height)
            
            self.paperFoldView.delegate = self
            self.paperFoldView.setLeftFoldContent(citiesListController!.view, foldCount: 5, pullFactor: 0.9)
            self.paperFoldView.setPaperFoldState(PaperFoldStateLeftUnfolded)
            self.mainContentViewContainer.setNeedsDisplay()
        }
    }
    
    public func dismissCitiesListController() {
        if self.sideViewState != .hidden {
            self.sideViewState = .hidden
            self.paperFoldView.setPaperFoldState(PaperFoldStateDefault)
            self.navigator!.topViewController!.viewWillAppear(true)
        }
    }

    public func toggleSideViewController() {
        switch self.sideViewState {
        case .hidden:
            self.showCitiesListController()
        case .showing:
            self.dismissCitiesListController()
        default:
            break
        }
    }
    
    public func showAddCitiesController() {
        if self.addCitiesController == nil {
            self.navigator.topViewController!.view.isUserInteractionEnabled = false
            
            self.addCitiesController = UINavigationController(rootViewController: self.assembly.addCityViewController() as! UIViewController)            
            
            self.addCitiesController!.view.frame = CGRect(x: 0, y: self.view.frame.origin.y + self.view.frame.size.height, width: SIDE_CONTROLLER_WIDTH, height: self.view.frame.size.height)
            self.view.addSubview(self.addCitiesController!.view)
            
            UIView.transition(with: self.view, duration: 0.25, options: .curveEaseInOut, animations: {
                
                self.addCitiesController!.view.frame = CGRect(x: 0, y: 0, width: self.SIDE_CONTROLLER_WIDTH, height: self.view.frame.size.height)
                
            }, completion: nil)
        }
    }
    
    public func dismissAddCitiesController() {
        if let addCitiesController = self.addCitiesController {
            self.citiesListController?.viewWillAppear(true)
            UIView.transition(with: self.view, duration: 0.25, options: .curveEaseInOut, animations: {
                
                addCitiesController.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.SIDE_CONTROLLER_WIDTH, height: self.view.frame.size.height)
                
            }, completion: {
                completed in
                
                addCitiesController.view.removeFromSuperview()
                self.addCitiesController = nil
                self.citiesListController?.viewDidAppear(true)
                self.navigator.topViewController!.view.isUserInteractionEnabled = true
            })
        }
    }
    
    //-------------------------------------------------------------------------------------------
    // MARK: - PaperFoldViewDelegate
    //-------------------------------------------------------------------------------------------
    public func paperFoldView(paperFoldView: AnyObject!, didFoldAutomatically automated: Bool, toState paperFoldState: PaperFoldState) {
        if paperFoldState.rawValue == 0 {
            self.navigator.topViewController!.viewDidAppear(true)
            
            
            let dummyView = UIView(frame: CGRect(x: 1, y: 1, width: 1, height: 1))
            self.paperFoldView.setLeftFoldContent(dummyView, foldCount: 0, pullFactor: 0)
            self.citiesListController = nil
        }
    }

    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden Methods
    //-------------------------------------------------------------------------------------------

    public override func loadView() {
        let screen = UIScreen.main.bounds
        self.paperFoldView = PaperFoldView(frame: CGRect(x: 0, y: 0, width: screen.size.width, height: screen.size.height))
        self.paperFoldView.timerStepDuration = 0.02
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        self.mainContentViewContainer = UIView(frame: self.paperFoldView.bounds)
        self.mainContentViewContainer.backgroundColor = .black
        self.paperFoldView.setCenterContent(self.mainContentViewContainer)
    }
    
    public override func viewWillLayoutSubviews() {
        self.mainContentViewContainer.frame = self.view.bounds
    }
    
    public override var shouldAutorotate: Bool {
        return self.navigator!.topViewController!.shouldAutorotate
    }
    
    public override func willRotate(to orientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.navigator!.topViewController!.willRotate(to: orientation, duration: duration)
    }
    
    public override func didRotate(from orientation: UIInterfaceOrientation) {
        self.navigator!.topViewController!.didRotate(from: orientation)
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
