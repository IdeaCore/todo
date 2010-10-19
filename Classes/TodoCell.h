//
//  TodoCell.h
//  ToDo
//
//  Created by Brian Stewart on 10/19/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;

@interface TodoCell : UITableViewCell {
	Todo *todo;
	UILabel *todoTextLabel;
	UILabel *todoPriorityLabel;
	UIImageView *todoPriorityImageView;
}

@property (nonatomic, retain) UILabel *todoTextLabel;
@property (nonatomic, retain) UILabel *todoPriorityLabel;
@property (nonatomic, retain) UIImageView *todoPriorityImageView;

-(UIImage *)imageForPriority:(NSInteger)priority;

-(Todo *)todo;
-(void)setTodo:(Todo *)newTodo;


@end
