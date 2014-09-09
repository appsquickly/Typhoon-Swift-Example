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


@protocol PFCityDao;
@class Theme;
@class FUISegmentedControl;
@class ApplicationAssembly;

@interface PFCitiesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _cities;
}

@property(nonatomic, strong, readonly) id <PFCityDao> cityDao;
@property(nonatomic, strong, readonly) Theme* theme;
@property(nonatomic, strong) ApplicationAssembly* assembly;

@property(nonatomic, weak) IBOutlet UITableView* citiesListTableView;
@property(nonatomic, weak) IBOutlet UISegmentedControl* temperatureUnitsControl;

- (id)initWithCityDao:(id <PFCityDao>)cityDao theme:(Theme*)theme;


@end
