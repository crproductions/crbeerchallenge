//
//  HomeViewController.m
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 1/11/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import "HomeViewController.h"
#import "BeerAppUser.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DrinkBeerViewController.h"

@interface HomeViewController ()<FBLoginViewDelegate>
@property (nonatomic,strong) AppDelegate *appDelegate;

@property(nonatomic, assign) int beerDrank;

@end

@implementation HomeViewController
@synthesize userFirstName, appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.lgvc = [[LoginViewController alloc]init];
    
    appDelegate = [[UIApplication sharedApplication]delegate];
    NSLog(@"Testing = %@",appDelegate.beerAppUser.loggedInUser);
    
    
    NSLog(@"Testing2 = %@",self.beerAppUser.loggedInUser);
    
    self.userFirstName.text = self.beerAppUser.loggedInUser.first_name;
    
    self.beerNameTF.delegate = self;
    self.beerNameButton.enabled = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DrinkBeerViewController *)drinkBeerViewController
{
    if (!_drinkBeerViewController) _drinkBeerViewController = [[DrinkBeerViewController alloc] init];
    
    _drinkBeerViewController.beerName = self.beerNameTF.text;
    _drinkBeerViewController.beerUser = self.beerAppUser;
    return _drinkBeerViewController;
    
}

#pragma mark FB Calls

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                } else if (error.fberrorCategory != FBErrorCategoryUserCancelled){
                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Permission denied"
                                                                                                        message:@"Unable to get permission to post"
                                                                                                       delegate:nil
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                    [alertView show];
                                                }
                                            }];
    } else {
        action();
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *testString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
   
        self.beerNameButton.enabled = testString.length > 0;
    
    return YES;
}


// Post Status Update button handler; will attempt different approaches depending upon configuration.
- (IBAction)postStatusUpdateClick:(UIButton *)sender {
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
    
    // This code demonstrates 3 different ways of sharing using the Facebook SDK.
    // The first method tries to share via the Facebook app. This allows sharing without
    // the user having to authorize your app, and is available as long as the user has the
    // correct Facebook app installed. This publish will result in a fast-app-switch to the
    // Facebook app.
    // The second method tries to share via Facebook's iOS6 integration, which also
    // allows sharing without the user having to authorize your app, and is available as
    // long as the user has linked their Facebook account with iOS6. This publish will
    // result in a popup iOS6 dialog.
    // The third method tries to share via a Graph API request. This does require the user
    // to authorize your app. They must also grant your app publish permissions. This
    // allows the app to publish without any user interaction.
    
    // If it is available, we will first try to post using the share dialog in the Facebook app
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:urlToShare
                                                          name:@"Hello Facebook"
                                                       caption:nil
                                                   description:@"The 'Hello Facebook' sample application showcases simple Facebook integration."
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"Error: %@", error.description);
                                                           } else {
                                                               NSLog(@"Success!");
                                                           }
                                                       }];
    
    if (!appCall) {
        // Next try to post using Facebook's iOS6 integration
        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                                              initialText:nil
                                                                                    image:nil
                                                                                      url:urlToShare
                                                                                  handler:nil];
        
        if (!displayedNativeDialog) {
            // Lastly, fall back on a request for permissions and a direct post using the Graph API
            [self performPublishAction:^{
               
                NSString *message;
                
                
                    message = [NSString stringWithFormat:@"%@ is drinking a bottle of %@", self.beerAppUser.loggedInUser.first_name, self.beerNameTF.text];
                
                
            
                
                FBRequestConnection *connection = [[FBRequestConnection alloc] init];
                
                connection.errorBehavior = FBRequestConnectionErrorBehaviorReconnectSession
                | FBRequestConnectionErrorBehaviorAlertUser
                | FBRequestConnectionErrorBehaviorRetry;
                
                [connection addRequest:[FBRequest requestForPostStatusUpdate:message]
                     completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                         
                         [self showAlert:message result:result error:error];
                         
                     }];
                [connection start];
                
               
            }];
        }
    }
}

// UIAlertView helper for post buttons
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertTitle = @"Error";
        // Since we use FBRequestConnectionErrorBehaviorAlertUser,
        // we do not need to surface our own alert view if there is an
        // an fberrorUserMessage unless the session is closed.
        if (error.fberrorUserMessage && FBSession.activeSession.isOpen) {
            alertTitle = nil;
            
        } else {
            // Otherwise, use a general "connection problem" message.
            alertMsg = @"Operation failed due to a connection problem, retry later.";
        }
    } else {
        //NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.", message];
//        NSString *postId = [resultDict valueForKey:@"id"];
//        if (!postId) {
//            postId = [resultDict valueForKey:@"postId"];
//        }
//        if (postId) {
//            alertMsg = [NSString stringWithFormat:@"%@\nPost ID: %@", alertMsg, postId];
//        }
        alertTitle = @"Success";
        
        [self.navigationController pushViewController:self.drinkBeerViewController animated:YES];

    }
    
    if (alertTitle) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                            message:alertMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}



@end
