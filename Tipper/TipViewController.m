//
//  ViewController.m
//  Tipper
//
//  Created by Peiqi Zheng on 9/6/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

//TODO: set a global rate;

#import "TipViewController.h"
#import "SettingsViewController.h"
#import <pop/POP.h>
#import <TSCurrencyTextField/TSCurrencyTextField.h>

@interface TipViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *tipSegControl;
@property (strong, nonatomic) IBOutlet UIButton *awesomeButton;
@property (nonatomic) NSInteger roundingMode;
@property (nonatomic) float rate;
- (IBAction)onTap:(id)sender;
- (IBAction)feelAwesomeButtonClicked:(UIButton *)sender;
-(void)updateValues:(float)rate;
-(void)getRateFromSeg;
@end

@implementation TipViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.roundingMode = [defaults integerForKey:@"rounding"];
    self.tipSegControl.selectedSegmentIndex = 0;
    [self getRateFromSeg];
    _billTextField.amount = @0.00;
    [[self.awesomeButton layer] setBorderWidth:1.0f];
    [[self.awesomeButton layer] setBorderColor:[UIColor blueColor].CGColor];
    _aaView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.roundingMode = [defaults integerForKey:@"rounding"];
    [self updateValues:self.rate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSettingsButton {
    [self performSegueWithIdentifier:@"settings" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"settings"]) {
        SettingsViewController *destinationVC = segue.destinationViewController;
        destinationVC.title = @"Settings";
    }
}

- (void)getRateFromSeg {
    switch (self.tipSegControl.selectedSegmentIndex) {
        case 0:
            self.rate = 0.15;
            break;
        case 1:
            self.rate = 0.18;
            break;
        case 2:
            self.rate = 0.2;
            break;
        default:
            self.rate = 0.15;
            break;
    }
}

- (IBAction)onTap:(id)sender {
    if (![sender isKindOfClass:[TSCurrencyTextField class]]) {
        [self.view endEditing:YES];
        if (_aaView.hidden) {
            [self showAAView];
        }
    }
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        [self getRateFromSeg];
    }
    [self updateValues:self.rate];
}

// generate a rate between 20% to 30%
// TODO: ask to save the restaurant name
- (IBAction)feelAwesomeButtonClicked:(UIButton *)sender {
    //animate button
    [self.view endEditing:YES];
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    springAnimation.toValue = @(2*M_PI);
    springAnimation.springBounciness = 20.0;
    springAnimation.springSpeed = 40.0;
    [sender.layer pop_addAnimation:springAnimation forKey:@"rotation"];
    
    self.rate = (arc4random_uniform(10)+20)/100.00;
    [self updateValues:self.rate];
    if (_aaView.hidden) {
        [self showAAView];
    }
}

- (void)showAAView {
    _aaView.hidden = NO;
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [_aaView pop_addAnimation:anim forKey:@"fade"];
}

- (void)updateValues:(float)rate {
    NSNumber *billAmount = _billTextField.amount;
    float tipAmount = [billAmount floatValue] * rate;
    float totalAmount = [billAmount floatValue] + tipAmount;
    float twoAmount = totalAmount/2.0;
    float threeAmount = totalAmount/3.0;
    float fourAmount = totalAmount/4.0;
    if (self.roundingMode == 1) {
        // round up
        totalAmount = ceilf(totalAmount);
        twoAmount = ceilf(twoAmount);
        threeAmount = ceilf(threeAmount);
        fourAmount = ceilf(fourAmount);
    } else if (self.roundingMode == 2) {
        // round ndown
        totalAmount = floorf(totalAmount);
        twoAmount = floorf(twoAmount);
        threeAmount = floorf(threeAmount);
        fourAmount = floorf(fourAmount);
    }
    self.tipLabel.text = [_billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:tipAmount]];
    self.totalLabel.text = [_billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:totalAmount]];
    _twoPeopleLabel.text = [_billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:twoAmount]];
    _threePeopleLabel.text = [_billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:threeAmount]];
    _fourPeopleLabel.text = [_billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:fourAmount]];
}

- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange: (NSRange)range replacementString: (NSString *) string
{
    NSAssert( FALSE, @"This should never be called.  TSCurrencyTextField doesn't pass this one on!");
    
    return YES;
}

- (void) textFieldDidBeginEditing: (UITextField *) textField
{
    NSLog( @"%@", NSStringFromSelector( _cmd ) );
}

- (void) textFieldDidEndEditing: (UITextField *) textField
{
    NSLog( @"%@", NSStringFromSelector( _cmd ) );    
}

@end
