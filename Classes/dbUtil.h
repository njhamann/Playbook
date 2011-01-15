//
//  dbUtil.h
//  IT-Dealer
//
//  Created by Noah Hamann on 9/20/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface dbUtil : NSObject {

}
-(void) copyDatabaseIfNeeded;
-(NSString *) getDBPath;
-(BOOL) playExist;
-(NSMutableArray *) getPlay; 
-(void) updateRecord:(NSMutableDictionary *)playInfo;
-(void) deletePlay:(NSInteger)idNum; 
-(void) addPlay:(NSMutableDictionary *)playInfo; 


@end
