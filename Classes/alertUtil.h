//
//  alertUtil.h
//  IT-Dealer
//
//  Created by Noah Hamann on 9/20/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//made changes

#import <UIKit/UIKit.h>


@interface alertUtil : NSObject {
    UIViewController *root;

}

@property (nonatomic, retain) UIViewController *root;

-(void)callAlert:(NSString *)alertTitle descriptionMsg:(NSString *)alertDescription;
-(void)callActionAlert:(NSString *)alertTitle descriptionMsg:(NSString *)alertDescription alertTagInt:(int)alertTag;

@end
