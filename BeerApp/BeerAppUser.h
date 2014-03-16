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



@property (nonatomic, retain)  id<FBGraphUser> loggedInUser;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *LastName;
@property (nonatomic, retain) NSDate *birthDate;
@property (nonatomic, assign) int nHeight;
@property (nonatomic, assign) int nWeight;
@property (nonatomic, retain) NSString *favoriteBeer;
@property (nonatomic, assign) BOOL isFilledUp;


@end
