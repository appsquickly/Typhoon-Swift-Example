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




#import <Foundation/Foundation.h>
#import "PFWeatherClient.h"
#import "PFThemeable.h"

@protocol PFCityDao;
@protocol PFWeatherClient;
@class PFRootViewController;


@interface PFAddCityViewController : UIViewController <UITextFieldDelegate, PFThemeable>


#pragma mark - Typhoon injected properties
@property(nonatomic, strong) id <PFCityDao> cityDao;
@property(nonatomic, strong) id <PFWeatherClient> weatherClient;
@property(nonatomic, strong) Theme* theme;
@property(nonatomic, strong) PFRootViewController* rootViewController;


#pragma mark - Interface Builder injected properties
@property(nonatomic, weak) IBOutlet UITextField* nameOfCityToAdd;
@property(nonatomic, weak) IBOutlet UILabel* validationMessage;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* spinner;


@end