//
//  Todo.h
//  ToDo
//
//  Created by Brian Stewart on 10/19/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Todo : NSObject {
	sqlite3 *database;
	NSInteger primaryKey;
	NSString *todoText;
	NSInteger priority;
}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, retain) NSString *todoText;
@property (nonatomic) NSInteger priority;

-(id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;

@end
