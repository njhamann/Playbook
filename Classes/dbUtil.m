//
//  dbUtil.m
//  IT-Dealer
//
//  Created by Noah Hamann on 9/20/10.
//  Copyright (c) 2010 Ratchet. All rights reserved.
//

#import "dbUtil.h"

static sqlite3 *database = nil;
static sqlite3_stmt *updateStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation dbUtil


-(void) copyDatabaseIfNeeded 
{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"playbook.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

-(NSString *) getDBPath 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"playbook.sqlite"];
}

-(BOOL) playExist
{
	BOOL playExist = NO;
	if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "SELECT * FROM play WHERE id = ?";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			sqlite3_bind_int(selectstmt, 1, 1);
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				playExist = YES;
			}
		}
	}
	else
	{
		sqlite3_close(database);	
	}
	return playExist;
}

-(NSMutableArray *) getPlay 
{
	NSMutableArray *records = [[NSMutableArray alloc] init];
	if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "SELECT * FROM play";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSMutableDictionary *row = [[NSMutableDictionary alloc] init];				
				[row setObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(selectstmt, 1)] forKey:@"play_name"];				
				[row setObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(selectstmt, 2)] forKey:@"description"];
				[row setObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(selectstmt, 3)] forKey:@"type"];				
				[row setObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(selectstmt, 4)] forKey:@"date"];				
				[row setObject:[NSString stringWithUTF8String:(char *) sqlite3_column_text(selectstmt, 5)] forKey:@"file_name"];				

				[records addObject:row];
			}
		}
	}
	else
	{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
	}
	return records;
}


-(void) updateRecord:(NSMutableDictionary *)playInfo 
{
	if(updateStmt == nil) 
	{
		const char *sql = "UPDATE play SET play_name = ?, description = ?, type = ?, date = ?, file_name = ?  WHERE id = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK) 
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
	}

	sqlite3_bind_text(updateStmt, 1, [[playInfo objectForKey:@"play_name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(updateStmt, 2, [[playInfo objectForKey:@"description"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(updateStmt, 3, [[playInfo objectForKey:@"type"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(updateStmt, 4, [[playInfo objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(updateStmt, 5, [[playInfo objectForKey:@"file_name"] UTF8String], -1, SQLITE_TRANSIENT);

	sqlite3_bind_int(updateStmt, 6, [[playInfo objectForKey:@"id"] intValue]);

	if(SQLITE_DONE != sqlite3_step(updateStmt))
	{
		NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
	}
	sqlite3_reset(updateStmt);
	updateStmt = nil;
}

-(void) deletePlay:(NSInteger)idNum 
{
	NSLog(@"deleted PHR num: %d",idNum);
	if(deleteStmt == nil) 
	{
		const char *sql = "DELETE FROM play WHERE id = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
	}
	
	sqlite3_bind_int(deleteStmt, 1, idNum);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
	{
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_reset(deleteStmt);
	deleteStmt = nil;
}


-(void) addPlay:(NSMutableDictionary *)playInfo 
{
	if(addStmt == nil) 
	{
		const char *sql = "INSERT INTO play(play_name, description, type, date, file_name) Values(?,?,?,?,?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
		{
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_text(addStmt, 1, [[playInfo objectForKey:@"play_name"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [[playInfo objectForKey:@"description"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 3, [[playInfo objectForKey:@"type"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 4, [[playInfo objectForKey:@"date"] UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 5, [[playInfo objectForKey:@"file_name"] UTF8String], -1, SQLITE_TRANSIENT);

	if(SQLITE_DONE != sqlite3_step(addStmt))
	{
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
		NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
	}
	sqlite3_reset(addStmt);
	addStmt = nil;
}




@end
