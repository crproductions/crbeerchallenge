//
//  FBSingleton.m
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 3/1/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import "FBSingleton.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FBSingleton

+ (FBSingleton*)facebookUser
{
    static FBSingleton *facebookUser = nil;
    if (!facebookUser) {  facebookUser = [[super allocWithZone:nil] init]; }
    return facebookUser;
}

+(id)allocWithZone:(NSZone *)zone { return [self facebookUser]; }

- (id)init {
    self = [super init];
    if (self) {  self.userLoged = NO; }
    return self;
}

- (void)logOut {
    [FBSession.activeSession closeAndClearTokenInformation];
}

-(void)logIn
{
    if (!self.userLoged) {
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler: ^(FBSession *session,  FBSessionState state, NSError *error) {
            [self sessionStateChanged:session state:state error:error];
        }];
    }
    else { [[NSNotificationCenter defaultCenter] postNotificationName:@"populateUserDetails" object:self]; }
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error {
    switch (state) {
            
        case FBSessionStateOpen: { [self populateUserDetails]; }
            break;
        case FBSessionStateClosed: { [self cleanUsser]; }
            break;
        case FBSessionStateClosedLoginFailed:
        {
            [FBSession.activeSession closeAndClearTokenInformation];
            [self cleanUsser];
        }
            
            break;
        default: { }
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) { [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error)
        {
            self.userFirstName = user.first_name;
            self.userLastName = user.last_name;
            self.userFullName = user.name;
            self.userId = user.id;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"populateUserDetails" object:self];
        }
    }];
    }
}


- (void)cleanUsser
{
    self.userFirstName = @"";
    self.userLastName = @"";
    self.userFullName = @"";
    self.userId = @"";
    self.userLoged = NO;
}

@end