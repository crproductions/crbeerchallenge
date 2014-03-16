//
//  FBSingleton.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 3/1/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface FBSingleton : NSObject
+ (FBSingleton*)facebookUser;
@property (nonatomic,retain) NSString *userFullName;
@property (nonatomic,retain) NSString *userFirstName;
@property (nonatomic,retain) NSString *userLastName;
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,assign) BOOL userLoged;
- (void)logIn;
- (void)logOut;
@end