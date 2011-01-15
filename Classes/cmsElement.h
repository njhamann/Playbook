//
//  cmsElement.h
//  IT-Dealer
//
//  Created by Noah Hamann on 9/13/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface cmsElement : NSObject {
    NSString *elementID;
    NSString *elementName;
}
@property(nonatomic, retain) NSString *elementID;
@property(nonatomic, retain) NSString *elementName;

@end
