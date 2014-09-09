//
//  ViewController.h
//  Tipper
//
//  Created by Peiqi Zheng on 9/6/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TSCurrencyTextField/TSCurrencyTextField.h>

@interface TipViewController : UIViewController
@property (strong, nonatomic) IBOutlet TSCurrencyTextField *billTextField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UIView *aaView;
@property (strong, nonatomic) IBOutlet UILabel *twoPeopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *threePeopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourPeopleLabel;
    
@end

