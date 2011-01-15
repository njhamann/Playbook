//
//  loadingView.m
//  IT-Dealer
//
//  Created by Julian Hays on 12/6/10.
//  Copyright 2010 Ratchet. All rights reserved.
//

#import "loadingView.h"
#import <QuartzCore/QuartzCore.h>


@implementation loadingView

- (id)addLoadingView:(UIView *)aSuperview loadMessage:(NSString *)message 
{
	NSLog(@" add loading view");
	//loadingView *loader = [[[loadingView alloc] initWithFrame:[aSuperview bounds]] autorelease];
	/*if (!loader)
	{
		return nil;
	}*/
	NSLog(@"loading view");
	self.opaque = NO;
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tag = 2001;

	[aSuperview addSubview:self];
	
	const CGFloat DEFAULT_LABEL_WIDTH = 280.0;
	const CGFloat DEFAULT_LABEL_HEIGHT = 50.0;
	CGRect labelFrame = CGRectMake(0, 0, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	UILabel *loadingLabel = [[[UILabel alloc] initWithFrame:labelFrame] autorelease];
	loadingLabel.text = NSLocalizedString(message, nil);
	loadingLabel.textColor = [UIColor whiteColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = UITextAlignmentCenter;
	loadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	loadingLabel.autoresizingMask =
	UIViewAutoresizingFlexibleLeftMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleBottomMargin;
	
	[self addSubview:loadingLabel];
	
	UIActivityIndicatorView *activityIndicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self addSubview:activityIndicatorView];
	
	//newLoadingView = [[UIView alloc] initWithFrame:CGRectMake(362, 309, 300, 150)];
	self.alpha = .7;
	self.backgroundColor = [UIColor blackColor];
	self.layer.cornerRadius = 5;
	
	
	//newLoadingView.layer.cornerRadius = 5;
	
	//self.backgroundColor = [UIColor clearColor];
	self.frame = CGRectMake(362, 120, 300, 200);
	activityIndicatorView.autoresizingMask =
	UIViewAutoresizingFlexibleLeftMargin |
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin |
	UIViewAutoresizingFlexibleBottomMargin;
	[activityIndicatorView startAnimating];
	
	CGFloat totalHeight =
	loadingLabel.frame.size.height +
	activityIndicatorView.frame.size.height;
	labelFrame.origin.x = floor(0.5 * (self.frame.size.width - DEFAULT_LABEL_WIDTH));
	labelFrame.origin.y = floor(0.5 * (self.frame.size.height - totalHeight));
	loadingLabel.frame = labelFrame;
	
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x =
	0.5 * (self.frame.size.width - activityIndicatorRect.size.width);
	activityIndicatorRect.origin.y =
	loadingLabel.frame.origin.y + loadingLabel.frame.size.height;
	activityIndicatorView.frame = activityIndicatorRect;
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	return self;
	
}

- (void)removeLoadingView
{
	NSLog(@"Inside removeLoadingView");
	
	UIView *aSuperview = [self superview];
	[self removeFromSuperview];
	[self release];
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

@end
