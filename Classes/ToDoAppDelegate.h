//
//  ToDoAppDelegate.h
//  ToDo
//
//  Created by Brian Stewart on 10/18/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class Todo;

@interface ToDoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	sqlite3 *database;
	NSMutableArray *todos;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *todos;

@end

