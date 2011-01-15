//
//  playViewController.h
//  Playbook
//
//  Created by Noah Hamann on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface playViewController : UIViewController {
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
-(void) buildAnimation;
-(void) playAnimation:(id)sender;

-(NSString *) pathForDataFile;
-(void) saveDataToDisk:(id)sender;
-(void) loadDataFromDisk:(id)sender;
-(NSMutableDictionary *) packageCurrentPlay;
-(void) displayLoadedPlay:(NSDictionary *)playInfo;
-(void) changeView:(id)sender;

@end
