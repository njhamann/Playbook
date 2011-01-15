    //
//  savedPlaysController.m
//  Playbook
//
//  Created by Noah Hamann on 1/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "savedPlaysController.h"
#import "savedPlaysListController.h"
#import "savedPlaysDetailController.h"

@implementation savedPlaysController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	savedPlaysListController *list = [[[savedPlaysListController alloc] init] autorelease];
	savedPlaysDetailController *detail = [[[savedPlaysDetailController alloc] init] autorelease]; 
	
	UINavigationController *listNav = [[[UINavigationController alloc] initWithRootViewController:list]autorelease];
	
	UINavigationController *detailNav = [[[UINavigationController alloc] initWithRootViewController:detail] autorelease];
	
	self.viewControllers = [NSArray arrayWithObjects:listNav, detailNav, nil];
	//self.delegate = detail;
	self.view.frame = CGRectMake(0, 0, 1024, 748);
	//list.view.frame = CGRectMake(0, 0, list.view.frame.size.width, 748);
	
}

//detailedView delegate methods
- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc
{  
    [barButtonItem setTitle:@"your title"];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //self.navigationItem.leftBarButtonItem = nil;
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
