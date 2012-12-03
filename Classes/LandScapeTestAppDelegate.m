//
//  LandScapeTestAppDelegate.m
//  LandScapeTest
//
//  Created by Craig Campbell on 4/26/09.
//  Copyright Georgia Institute of Technology 2009. All rights reserved.
//

#import "LandScapeTestAppDelegate.h"
#import "LandScapeTestViewController.h"

@implementation LandScapeTestAppDelegate

@synthesize ls;
@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
	[window addSubview:ls];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
	[ls release];
    [super dealloc];
}


@end
