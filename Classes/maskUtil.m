//
//  maskUtil.m
//  IT-Dealer
//
//  Created by Noah Hamann on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "maskUtil.h"


@implementation maskUtil

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
	
	CGImageRef maskRef = maskImage.CGImage; 
	
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	return [UIImage imageWithCGImage:masked];
	
}

@end
