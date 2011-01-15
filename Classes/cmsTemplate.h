//
//  cmsTemplate.h
//  IT-Dealer
//
//  Created by Noah Hamann on 9/13/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface cmsTemplate : NSObject {
    NSString *templateID;
    NSString *templateName;
    NSMutableArray *templateElements;
}
@property (nonatomic, retain) NSString *templateID;
@property (nonatomic, retain) NSString *templateName;
@property (nonatomic, retain) NSMutableArray *templateElements;


@end
