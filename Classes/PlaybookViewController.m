//
//  PlaybookViewController.m
//  Playbook
//
//  Created by Noah Hamann on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaybookViewController.h"
#import "itemController.h"
#import "savedPlaysController.h"
#import "playViewController.h"

@implementation PlaybookViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	playViewController *playViewControl = [[playViewController alloc] init];
	[self.view addSubview:playViewControl.view];
	
	//savedPlaysController *savedPlaysControl = [[savedPlaysController alloc] init];

	//[self.view addSubview:savedPlaysControl.view];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}

@end
