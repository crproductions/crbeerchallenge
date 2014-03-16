//
//  RegistrationViewController.h
//  BeerApp
//
//  Created by Ralph Jazer Rebong on 3/1/14.
//  Copyright (c) 2014 SarileProductions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *firstNameTF;
@property (nonatomic, weak) IBOutlet UITextField *lastNameTF;
@property (nonatomic, weak) IBOutlet UIDatePicker *dateofBirth;
@property (nonatomic, weak) IBOutlet UITextField *favoriteBeerTF;
@property (nonatomic, weak) IBOutlet UITextField *weightTF;
@property (nonatomic, weak) IBOutlet UITextField *heightTF;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end
