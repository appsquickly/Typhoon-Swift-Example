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




#import "PFAddCityViewController.h"
#import "PFCityDao.h"
#import "UIFont+ApplicationFonts.h"
#import "PFRootViewController.h"
#import "PocketForecast-Swift.h"


@implementation PFAddCityViewController


/* ============================================================ Initializers ============================================================ */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)dealloc
{
    NSLog(@"***** %@ in dealloc *****", self);
}

- (void)typhoonWillInject
{
    if (self.view) //Eagerly load view
    {
    }
}

- (void)typhoonDidInject
{
    [self validateRequiredProperties];
    [self applyTheme];
}


/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameOfCityToAdd setFont:[UIFont applicationFontOfSize:16]];
    [_validationMessage setFont:[UIFont applicationFontOfSize:16]];

    [self setTitle:@"Add City"];
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAdding:)];
    [_nameOfCityToAdd becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_validationMessage setHidden:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doneAdding:textField];
    return YES;
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)doneAdding:(id)sender
{
    if ([[_nameOfCityToAdd text] length] > 0)
    {
        [_validationMessage setText:@"Validating city . ."];
        [_nameOfCityToAdd setEnabled:NO];
        [_validationMessage setHidden:NO];
        [_spinner startAnimating];

        __weak id <PFCityDao> cityDao = _cityDao;

        [_weatherClient loadWeatherReportFor:[_nameOfCityToAdd text] onSuccess:^(WeatherReport *weatherReport)
        {
            LogDebug(@"Got weather report: %@", weatherReport);
            [cityDao saveCity:[weatherReport cityDisplayName]];
            [_rootViewController dismissAddCitiesController];
        } onError:^(NSString *message)
        {
            [_spinner stopAnimating];
            [_nameOfCityToAdd setEnabled:YES];
            [_validationMessage setText:[NSString stringWithFormat:@"No weather reports for '%@'.", [_nameOfCityToAdd text]]];
        }];
    }
    else
    {
        [_nameOfCityToAdd resignFirstResponder];
        [_rootViewController dismissAddCitiesController];
    }
}

- (void)validateRequiredProperties
{
    if (!_weatherClient)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Property weatherClient is required."];
    }
    if (!_cityDao)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Property cityDao is required."];
    }
}

- (void)applyTheme
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setBarTintColor:_theme.navigationBarColor];

    });
}

@end