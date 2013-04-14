//
//  IJAppDelegate.m
//  iJSONBenchmark
//
//  Created by admin on 4/14/13.
//  Copyright (c) 2013 Andrii Mamchur. All rights reserved.
//

#import "IJBAppDelegate.h"
#import "IJBViewController.h"

@implementation IJBAppDelegate

- (void)dealloc {
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.viewController = [[[IJBViewController alloc] initWithNibName:@"IJBViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
