//
//  TodoViewController.h
//  ToDo
//
//  Created by Brian Stewart on 10/20/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;

@interface TodoViewController : UIViewController {
	IBOutlet UITextView *todoText;
	IBOutlet UISegmentedControl *todoPriority;
	IBOutlet UILabel *todoStatus;
	IBOutlet UIButton *todoButton;
	Todo *todo;
}

@property (nonatomic, retain) IBOutlet UITextView *todoText;
@property (nonatomic, retain) IBOutlet UISegmentedControl *todoPriority;
@property (nonatomic, retain) IBOutlet UILabel *todoStatus;
@property (nonatomic, retain) IBOutlet UIButton *todoButton;
@property (nonatomic, retain) Todo *todo;

-(IBAction)updateStatus:(id)sender;
-(IBAction)updatePriority:(id)sender;

@end
