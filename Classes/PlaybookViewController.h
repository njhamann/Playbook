//
//  PlaybookViewController.h
//  Playbook
//
//  Created by Noah Hamann on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaybookViewController : UIViewController {
	NSTimer *timer;
	NSInteger animCounter;
	NSMutableArray *items;
	NSMutableArray *itemsPos;
	NSMutableArray *paths;
	float animationTime;
	bool isRecording;
	bool isPlaying;

}
-(void) startTimer:(id)sender;
-(void) updateCounter:(id)sender;
-(void) stopTimer:(id)sender;
-(void) buildButtons;
-(void) buildAnimation:(id)sender;
-(void) playAnimation; 

@end

