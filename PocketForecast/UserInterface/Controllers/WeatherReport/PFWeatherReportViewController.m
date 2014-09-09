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




#import "PFWeatherReportViewController.h"
#import "PFWeatherReportDao.h"
#import "PFCityDao.h"
#import "Typhoon.h"
#import "PFWeatherReportView.h"
#import "PFRootViewController.h"
#import "PFProgressHUD.h"
#import "PocketForecast-Swift.h"


@implementation PFWeatherReportViewController


/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithWeatherClient:(id <PFWeatherClient>)weatherClient weatherReportDao:(id <PFWeatherReportDao>)weatherReportDao
    cityDao:(id <PFCityDao>)cityDao theme:(Theme *)theme assembly:(ApplicationAssembly *)assembly;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _weatherClient = weatherClient;
        _weatherReportDao = weatherReportDao;
        _cityDao = cityDao;
        _theme = theme;
        _assembly = assembly;
    }
    return self;
}

/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

- (void)loadView
{
    PFWeatherReportView *view = [[PFWeatherReportView alloc] initWithFrame:CGRectZero];
    [view setTheme:_theme];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    _cityName = [_cityDao loadSelectedCity];
    _weatherReport = [_weatherReportDao getReportForCityName:_cityName];
    if (_weatherReport)
    {
        [(PFWeatherReportView *) self.view setWeatherReport:_weatherReport];
    }
    else if (_cityName)
    {
        [self refreshData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_cityName)
    {
        UIBarButtonItem *cityListButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(presentMenu)];
        [cityListButton setTintColor:[UIColor whiteColor]];

        UIBarButtonItem *space = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *refreshButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
        [refreshButton setTintColor:[UIColor whiteColor]];

        [((PFWeatherReportView *) self.view).toolbar setItems:@[
            cityListButton,
            space,
            refreshButton
        ]];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)refreshData
{
    __weak PFWeatherReportView *view = (PFWeatherReportView *) self.view;
    [PFProgressHUD present];
    [_weatherClient loadWeatherReportFor:_cityName onSuccess:^(WeatherReport *report)
    {
        LogDebug(@"Got report: %@", report);
        [view setWeatherReport:report];
        [PFProgressHUD dismiss];
    } onError:^(NSString *message)
    {
        [PFProgressHUD dismiss];
        LogDebug(@"Error %@", message);
    }];
}

- (void)presentMenu
{
    //Here we could have injected the root controller itself, however its useful to see the TyphoonComponentFactory itself being injected,
    //and posing behind an assembly interface.

    [[_assembly rootViewController] toggleSideViewController];
}


@end
