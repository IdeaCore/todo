//
//  RootViewController.m
//  ToDo
//
//  Created by Brian Stewart on 10/18/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import "RootViewController.h"
#import "TodoViewController.h"
#import "ToDoAppDelegate.h"
#import "Todo.h"
#import "TodoCell.h"

@implementation RootViewController

@synthesize todoView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Todo items";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	ToDoAppDelegate *appDelegate = (ToDoAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.todos.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	 TodoCell *cell = (TodoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[[TodoCell alloc] initWithFrame:CGRectZero] autorelease];
	 }
	 
	 // Configure the cell.
	 ToDoAppDelegate *appDelegate = (ToDoAppDelegate *)[[UIApplication sharedApplication] delegate];
	 Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	 
	 [cell setTodo:td];
	
	return cell;
	
	// Created two ways to show the database
	
	// Note: when using this one deselect the cell in the didselectrowatindexpath method
	// Loads the UITableViewCell class
    /*
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	 }
	 
	 ToDoAppDelegate *appDelegate = (ToDoAppDelegate *)[[UIApplication sharedApplication] delegate];
	 Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	 
	 UIImage *priorityImage;
	 NSString *priorityText;
	 switch (td.priority) {
	 case 1:
	 priorityText = @"High";
	 priorityImage = [UIImage imageNamed:@"red.png"];
	 break;
	 case 2:
	 priorityText = @"Medium";
	 priorityImage = [UIImage imageNamed:@"yellow.png"];
	 break;
	 case 3:
	 priorityText = @"Low";
	 priorityImage = [UIImage imageNamed:@"green.png"];
	 break;
	 default:
	 priorityText = @"High";
	 priorityImage = [UIImage imageNamed:@"red.png"];
	 break;
	 }
	 
	 // Configure the cell.
	 cell.textLabel.text = td.todoText;
	 cell.detailTextLabel.text = priorityText;
	 cell.imageView.image = priorityImage;
	 */
	
	// Loads the TodoCell class instead
	/*
	 TodoCell *cell = (TodoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[[TodoCell alloc] initWithFrame:CGRectZero] autorelease];
	 }
	 
	 // Configure the cell.
	 ToDoAppDelegate *appDelegate = (ToDoAppDelegate *)[[UIApplication sharedApplication] delegate];
	 Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	 
	 [cell setTodo:td];
	 */
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	ToDoAppDelegate *appDelegate = (ToDoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *td = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if (self.todoView == nil) {
		TodoViewController *viewControlelr = [[TodoViewController alloc] initWithNibName:@"TodoViewController"
																				  bundle:[NSBundle mainBundle]];
		self.todoView = viewControlelr;
		[viewControlelr release];
	}
	
	[self.navigationController pushViewController:self.todoView animated:YES];
	
	self.todoView.todo = td;
	self.todoView.title = td.todoText;
	[self.todoView.todoText setText:td.todoText];
	
	NSInteger priority = td.priority - 1;
	if (priority > 2 || priority < 0) {
		priority = 1;
	}
	priority = 2 - priority;
	
	[self.todoView.todoPriority setSelectedSegmentIndex:priority];
	
	NSString *buttonTitle;
	NSString *statusTitle;
	
	if (td.status == 1) {
		buttonTitle = @"Mark as in progress";
		statusTitle = @"Complete";
	} else {
		buttonTitle = @"Mark as complete";
		statusTitle = @"In progress";
	}
	
	[self.todoView.todoButton setTitle:buttonTitle forState:UIControlStateNormal];
	[self.todoView.todoButton setTitle:buttonTitle forState:UIControlStateHighlighted];
	[self.todoView.todoStatus setText:statusTitle];
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[todoView release];
    [super dealloc];
}


@end

