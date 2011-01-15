//
//  alertUtil.m
//  IT-Dealer
//
//  Created by Noah Hamann on 9/20/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//made a changed

#import "alertUtil.h"
//#import "IT_DealerViewController.h"

@implementation alertUtil
@synthesize root;
-(void)callAlert:(NSString *)alertTitle descriptionMsg:(NSString *)alertDescription
{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertDescription delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil] autorelease];
    [alert show];
	
	
}
-(void)callAlertTwo:(NSString *)alertTitle descriptionMsg:(NSString *)alertDescription alertTagInt:(int)alertTag
{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertDescription delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil] autorelease];
   	[alert setTag:alertTag];

	[alert show];
	
	
}
-(void)callActionAlert:(NSString *)alertTitle descriptionMsg:(NSString *)alertDescription alertTagInt:(int)alertTag
{
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertDescription delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil] autorelease];
	[alert setTag:alertTag];
	[alert addButtonWithTitle:@"Yes"];
    [alert show];


}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        if (buttonIndex == 0) {
			NSLog(@"0");
        }else{
			NSLog(@"1");
			///IT_DealerViewController *root = [[IT_DealerViewController alloc] init];
			//[root setPage:221];

		}
    }else if ([alertView tag] == 2) {
		[root setPage:[alertView tag]];
	}
}

@end
