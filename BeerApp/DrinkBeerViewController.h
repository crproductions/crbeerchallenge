//
//  DrinkBeerViewController.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 3/15/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "BeerAppUser.h"

@interface DrinkBeerViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *drinkAnotherBottleButton;
@property (nonatomic, weak) IBOutlet UILabel *beerNameLabel;
@property (nonatomic, strong) NSString *beerName;
@property (nonatomic, strong) BeerAppUser *beerUser;


@end
