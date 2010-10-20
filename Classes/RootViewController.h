//
//  RootViewController.h
//  ToDo
//
//  Created by Brian Stewart on 10/18/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoViewController;

@class ToDoAppDelegate;
@class Todo;
@class TodoCell;

@interface RootViewController : UITableViewController {
	
	TodoViewController *todoView;
}

@property (nonatomic, retain) TodoViewController *todoView;

@end
