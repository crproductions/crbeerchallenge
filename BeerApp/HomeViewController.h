//
//  HomeViewController.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 1/11/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "BeerAppUser.h"
#import "DrinkBeerViewController.h"

@interface HomeViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userFirstName;
@property (nonatomic,strong) BeerAppUser *beerAppUser;
@property (weak, nonatomic) IBOutlet UITextField *beerNameTF;
@property (nonatomic, strong) NSString *beerName;
@property (nonatomic, weak) IBOutlet UIButton *beerNameButton;
@property (nonatomic, strong) DrinkBeerViewController *drinkBeerViewController;

@end
