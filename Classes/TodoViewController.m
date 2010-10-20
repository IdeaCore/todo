//
//  TodoViewController.m
//  ToDo
//
//  Created by Brian Stewart on 10/20/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import "TodoViewController.h"

#import "Todo.h"

@implementation TodoViewController

@synthesize todoText, todoPriority, todoStatus, todoButton, todo;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)updateStatus:(id)sender {
	
	NSString *buttonTitle;
	NSString *statusTitle;
	NSInteger status;
	
	if (self.todo.status == 0) {
		buttonTitle = @"Mark as in progress";
		statusTitle = @"Complete";
		status = 1;
	} else {
		buttonTitle = @"Mark as complete";
		statusTitle = @"In progress";
		status = 0;
	}
	
	[self.todoButton setTitle:buttonTitle forState:UIControlStateNormal];
	[self.todoButton setTitle:buttonTitle forState:UIControlStateHighlighted];
	[self.todoStatus setText:statusTitle];
	[self.todo updateStatus:status];
}

- (IBAction)updatePriority:(id)sender {
	int priority = [self.todoPriority selectedSegmentIndex];
	
	/*
	 * Segmented controller:
	 * low = 0;
	 * medium = 1;
	 * high = 2;
	 *
	 * priority:
	 * low = 3;
	 * medium = 2;
	 * high = 1;
	 */
	
	[self.todo updatePriority:(2 - priority + 1)];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
