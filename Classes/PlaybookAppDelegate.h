//
//  PlaybookAppDelegate.h
//  Playbook
//
//  Created by Noah Hamann on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaybookViewController;

@interface PlaybookAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PlaybookViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PlaybookViewController *viewController;

@end

