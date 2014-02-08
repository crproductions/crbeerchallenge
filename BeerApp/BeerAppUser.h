//
//  BeerAppUser.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 1/22/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BeerAppUser : NSObject

extern id<FBGraphUser> loggedInUser;

@property (nonatomic, strong)  id<FBGraphUser> loggedInUser;

@end
