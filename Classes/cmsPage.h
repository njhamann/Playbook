//
//  cmsPage.h
//  IT-Dealer
//
//  Created by Noah Hamann on 9/13/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface cmsPage : NSObject {
    NSString *pageID;
    NSString *pageName;
    NSString *pageTemplateID;
    NSString *parentID;
    NSString *image;
    NSMutableArray *pageProperties;

}
@property(nonatomic, retain) NSString *pageID;
@property(nonatomic, retain) NSString *pageName;
@property(nonatomic, retain) NSString *pageTemplateID;
@property(nonatomic, retain) NSString *parentID;
@property(nonatomic, retain) NSString *image;
@property(nonatomic, retain) NSMutableArray *pageProperties;


@end
