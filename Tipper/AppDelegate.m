//
//  AppDelegate.m
//  Tipper
//
//  Created by Peiqi Zheng on 9/6/14.
//  Copyright (c) 2014 Peiqi Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "TipViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSDate *now = [NSDate date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:now forKey:@"lastTime"];
    [defaults synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *last = [defaults objectForKey:@"lastTime"];
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:last];
    if (interval > 10*60) {
        UINavigationController *navC = (UINavigationController*) self.window.rootViewController;
        TipViewController *tipVC = (TipViewController*) [[navC viewControllers] objectAtIndex:0];
        tipVC.aaView.hidden = YES;
        tipVC.billTextField.amount = @0.00;
        tipVC.tipLabel.text = [tipVC.billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:0.00]];
        tipVC.totalLabel.text = [tipVC.billTextField.currencyNumberFormatter stringFromNumber:[NSNumber numberWithFloat:0.00]];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
