//
//  PlaybookViewController.m
//  Playbook
//
//  Created by Noah Hamann on 1/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlaybookViewController.h"
#import "itemController.h"
#import <QuartzCore/QuartzCore.h>
#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)
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
	animCounter = 0;
	isRecording = NO;
	isPlaying = NO;
	items = [[NSMutableArray alloc] init];
	[self buildButtons];
}



-(void) buildButtons
{
	UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	startBtn.frame = CGRectMake(0, 0, 100, 50);
	[startBtn setTitle:@"Start Timer" forState:UIControlStateNormal];
	startBtn.backgroundColor = [UIColor blackColor];
	startBtn.adjustsImageWhenHighlighted = YES;
	[startBtn addTarget:self action:@selector(startTimer:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:startBtn];
	
	UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	stopBtn.frame = CGRectMake(120, 0, 100, 50);
	[stopBtn setTitle:@"Stop Timer" forState:UIControlStateNormal];
	stopBtn.backgroundColor = [UIColor blackColor];
	stopBtn.adjustsImageWhenHighlighted = YES;
	[stopBtn addTarget:self action:@selector(stopTimer:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:stopBtn];
	
	UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playBtn.frame = CGRectMake(240, 0, 100, 50);
	[playBtn setTitle:@"Play Animation" forState:UIControlStateNormal];
	playBtn.backgroundColor = [UIColor blackColor];
	playBtn.adjustsImageWhenHighlighted = YES;
	[playBtn addTarget:self action:@selector(buildAnimation:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:playBtn];
}



- (void)playAnimation 
{	
	//self.view.backgroundColor = [UIColor greenColor];	
	/*
	 UIBezierPath *trackPath = [UIBezierPath bezierPath];
	 [trackPath moveToPoint:P(160, 25)];
	 [trackPath addCurveToPoint:P(300, 120)
	 controlPoint1:P(320, 0)
	 controlPoint2:P(300, 80)];
	 [trackPath addCurveToPoint:P(80, 380)
	 controlPoint1:P(300, 200)
	 controlPoint2:P(200, 480)];
	 [trackPath addCurveToPoint:P(140, 300)
	 controlPoint1:P(0, 300)
	 controlPoint2:P(200, 220)];
	 [trackPath addCurveToPoint:P(210, 200)
	 controlPoint1:P(30, 420)
	 controlPoint2:P(280, 300)];
	 [trackPath addCurveToPoint:P(70, 110)
	 controlPoint1:P(110, 80)
	 controlPoint2:P(110, 80)];
	 [trackPath addCurveToPoint:P(160, 25)
	 controlPoint1:P(0, 160)
	 controlPoint2:P(0, 40)];
	 */
	
	/*
	 CAShapeLayer *racetrack = [CAShapeLayer layer];
	 racetrack.path = trackPath.CGPath;
	 racetrack.strokeColor = [UIColor blackColor].CGColor;
	 racetrack.fillColor = [UIColor clearColor].CGColor;
	 racetrack.lineWidth = 30.0;
	 [self.view.layer addSublayer:racetrack];
	 
	 CAShapeLayer *centerline = [CAShapeLayer layer];
	 centerline.path = trackPath.CGPath;
	 centerline.strokeColor = [UIColor whiteColor].CGColor;
	 centerline.fillColor = [UIColor clearColor].CGColor;
	 centerline.lineWidth = 2.0;
	 centerline.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:2], nil];
	 [self.view.layer addSublayer:centerline];
	 */
	/*
	 
	 CALayer *car = [CALayer layer];
	 car.bounds = CGRectMake(0, 0, 44.0, 20.0);
	 car.position = P(160, 25);
	 car.contents = (id)([UIImage imageNamed:@"carmodel.png"].CGImage);
	 [self.view.layer addSublayer:car];
	 */
	/*
	 
	 UIView *item = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	 item.center = CGPointMake(0, 0);
	 item.backgroundColor = [UIColor blackColor];
	 item.tag = 1;
	 [self.view addSubview:item];
	 
	 */
	animationTime = [[itemsPos objectAtIndex:0] count]*0.01;

	for(int i=0; i<[items count]; i++)
	{
		UIView *currentView = [items objectAtIndex:i];
		[self.view addSubview:currentView];
		UIBezierPath *trackPath = [paths objectAtIndex:i];
		CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		anim.path = trackPath.CGPath;
		anim.rotationMode = kCAAnimationRotateAuto;
		//anim.repeatCount = HUGE_VALF;
		anim.duration = animationTime;
		[currentView.layer addAnimation:anim forKey:@"race"];
		
	}
}



-(void) buildAnimation:(id)sender
{
	for(int i=0; i<[itemsPos count]; i++)
	{
		UIBezierPath *trackPath = [UIBezierPath bezierPath];
		[trackPath moveToPoint:[[[itemsPos objectAtIndex:i] objectAtIndex:0] CGPointValue]];

		for(int z=0; z<[[itemsPos objectAtIndex:i] count]; z++)
		{
			CGPoint newPoint = [[[itemsPos objectAtIndex:i] objectAtIndex:z] CGPointValue];
			[trackPath addLineToPoint:newPoint];
		}
		[paths addObject:trackPath];
	}
	[self playAnimation];
}


-(void) startTimer:(id)sender
{
	paths = [[NSMutableArray alloc] init];
	itemsPos = [[NSMutableArray alloc] init];
	for(int i=0; i<[items count]; i++)
	{
		NSMutableArray *positions = [[NSMutableArray alloc] init];
		[itemsPos addObject:positions];
	}
	isRecording = YES;
	timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
	
}
-(void) updateCounter:(id)sender
{
	
	for(int i=0; i<[items count]; i++)
	{		
		UIView *item = [items objectAtIndex:i];
		NSValue *pos = [NSValue valueWithCGPoint:item.center];
		[[itemsPos objectAtIndex:i] addObject:pos];
	}
}

-(void) stopTimer:(id)sender
{
	isRecording = NO;
	[timer invalidate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = [[event allTouches] anyObject];

	if (touch.tapCount == 2) {
	}else if(touch.tapCount == 1 && !isRecording){
		itemController *itemControl = [[itemController alloc] init];
		UIView *item = itemControl.view;
		item.center = [touch locationInView:self.view];
		item.tag = 1;
		[self.view addSubview:item];
		[items addObject:item];
		NSMutableArray *pos = [[NSMutableArray alloc] init];
		[itemsPos addObject:pos];
		
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesMoved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesEnded");
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
