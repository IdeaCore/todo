//
//  Todo.m
//  ToDo
//
//  Created by Brian Stewart on 10/19/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import "Todo.h"

static sqlite3_stmt *init_statement = nil;
static sqlite3_stmt *dehydrate_statement = nil;

@implementation Todo

@synthesize primaryKey, todoText, priority, status;

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
	if (self = [super init]) {
		primaryKey = pk;
		database = db;
		
		// Compile the query for retrieving book data.
		if (init_statement == nil) {
			// ? at the end of the query is a parameter which can be replaced by a bound variable.
			const char *sql = "SELECT text,priority,complete FROM todo WHERE pk=?";
			if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.",sqlite3_errmsg(database));
			}
		}
		// For this query, we bind the primary key to the first placeholder in the statement (? in sql string).
		// Note: parameters are numbered from 1, not from 0.
		sqlite3_bind_int(init_statement, 1, primaryKey);
		if (sqlite3_step(init_statement) == SQLITE_ROW) {
			self.todoText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
			self.priority = sqlite3_column_int(init_statement, 1);
			self.status = sqlite3_column_int(init_statement, 2);
		} else {
			self.todoText = @"Nothing";
		}
		
		// Reset the statement for future reuse.
		sqlite3_reset(init_statement);
	}
	return self;
}

- (void)updateStatus:(NSInteger)newStatus {
	self.status = newStatus;
	dirty = YES;
}

- (void)updatePriority:(NSInteger)newPriority {
	self.priority = newPriority;
	dirty = YES;
}

- (void)dehydrate {
	if (dirty) {
		if (dehydrate_statement == nil) {
			const char *sql = "UPDATE todo SET priority = ?,complete = ? WHERE pk=?";
			if (sqlite3_prepare_v2(database, sql, -1, &dehydrate_statement, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
		}
		
		/* 
		 * Second parameter is the what question mark
		 * it will replace in sql string.
		 */
		sqlite3_bind_int(dehydrate_statement, 3, self.primaryKey);
		sqlite3_bind_int(dehydrate_statement, 2, self.status);
		sqlite3_bind_int(dehydrate_statement, 1, self.priority);
		int success = sqlite3_step(dehydrate_statement);
		
		if (success != SQLITE_DONE) {
			NSAssert1(0, @"Error: Failed to save priority with message '%s'.", sqlite3_errmsg(database));
		}
		
		sqlite3_reset(dehydrate_statement);
		dirty = NO;
	}
}

@end
