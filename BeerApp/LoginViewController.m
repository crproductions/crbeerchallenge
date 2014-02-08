//
//  LoginViewController.m
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 1/11/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "BeerAppUser.h"
#import "AppDelegate.h"

@interface LoginViewController ()<FBLoginViewDelegate>

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation LoginViewController

@synthesize appDelegate;

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
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, (self.view.frame.size.width/2 - loginview.frame.size.width/2)/2, 116);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginview.frame = CGRectOffset(loginview.frame, (self.view.frame.size.width/2 - loginview.frame.size.width/2)/2, 136);
    }
#endif
#endif
#endif
    loginview.delegate = self;
    
    NSLog(@"Width = %f",self.view.frame.size.width/2);
    NSLog(@"Width login = %f",loginview.frame.size.width/2);
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Facebook Login Delegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
   
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:homeVC animated:YES];
    
    
   
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.loggedInUser = user;
    NSLog(@"WHAT = %@",appDelegate.loggedInUser.first_name);
    
    
}


- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}





@end
