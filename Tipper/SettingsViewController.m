//
//  SettingsViewController.m
//  Tipper
//
//  Created by Peiqi Zheng on 9/6/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
//@property (strong, nonatomic) IBOutlet UITextField *currencyTextField;

@property (strong, nonatomic) IBOutlet UISegmentedControl *roundingSegControl;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.roundingSegControl addTarget:self action:@selector(roundingSegControlClicked) forControlEvents:UIControlEventValueChanged];
    NSInteger roundingStored = [defaults integerForKey:@"rounding"];
    self.roundingSegControl.selectedSegmentIndex = roundingStored;
    
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)roundingSegControlClicked{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.roundingSegControl.selectedSegmentIndex forKey:@"rounding"];
    [defaults synchronize];
}


@end
