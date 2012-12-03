//
//  LandScapeTestAppDelegate.h
//  LandScapeTest
//
//  Created by Craig Campbell on 4/26/09.
//  Copyright Georgia Institute of Technology 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LandScapeTestViewController;

@interface LandScapeTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LandScapeTestViewController *viewController;
	UIView *ls;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIView *ls;
@property (nonatomic, retain) IBOutlet LandScapeTestViewController *viewController;

@end

