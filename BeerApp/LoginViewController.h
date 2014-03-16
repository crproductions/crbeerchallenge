//
//  LoginViewController.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 1/11/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "BeerAppUser.h"

@interface LoginViewController : UIViewController
@property (nonatomic, strong)  BeerAppUser *beerAppUser;

@end
