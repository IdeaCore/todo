//
//  TodoCell.m
//  ToDo
//
//  Created by Brian Stewart on 10/19/10.
//  Copyright 2010 Perry High School. All rights reserved.
//

#import "TodoCell.h"
#import "Todo.h"

static UIImage *priorityImage1 = nil;
static UIImage *priorityImage2 = nil;
static UIImage *priorityImage3 = nil;

@interface TodoCell()
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor
							fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end

@implementation TodoCell

@synthesize todoTextLabel, todoPriorityLabel, todoPriorityImageView;

+ (void)initialize {
	// The priority images are cached as part of the class, so they need to be explicitly retained.
	priorityImage1 = [[UIImage imageNamed:@"red.png"] retain];
	priorityImage2 = [[UIImage imageNamed:@"yellow.png"] retain];
	priorityImage3 = [[UIImage imageNamed:@"green.png"] retain];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		UIView *myContentView = self.contentView;
		
		self.todoPriorityImageView = [[UIImageView alloc] initWithImage:priorityImage1];
		[myContentView addSubview:self.todoPriorityImageView];
		[self.todoPriorityImageView release];
		
		self.todoTextLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor]
												   fontSize:14.0 bold:YES];
		self.todoTextLabel.textAlignment = UITextAlignmentLeft; // Default
		[myContentView addSubview:self.todoTextLabel];
		[self.todoTextLabel release];
		
		self.todoPriorityLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor]
													   fontSize:10.0 bold:YES];
		self.todoPriorityLabel.textAlignment = UITextAlignmentRight;
		[myContentView addSubview:self.todoPriorityLabel];
		[self.todoPriorityLabel release];
		
		// Position the todoPriorityImage above all the other views so it's not obscured.
		// It's a transparent image so any views that overlap it will still be visible.
		[myContentView bringSubviewToFront:self.todoPriorityImageView];
	}
	return self;
}

- (Todo *)todo {
	return self.todo;
}

- (void)setTodo:(Todo *)newTodo {
	
	todo = newTodo;
	
	self.todoTextLabel.text = newTodo.todoText;
	self.todoPriorityImageView.image = [self imageForPriority:newTodo.priority];
	
	switch (newTodo.priority) {
		case 2:
			self.todoPriorityLabel.text = @"Medium";
			break;
		case 3:
			self.todoPriorityLabel.text = @"Low";
			break;
		default:
			self.todoPriorityLabel.text = @"High";
			break;
	}
	[self setNeedsDisplay];
}

- (void)layoutSubviews {
	
#define LEFT_COLUMN_OFFSET 1
#define LEFT_COLUMN_WIDTH 50
	
#define RIGHT_COLUMN_OFFSET 75
#define RIGHT_COLUMN_WIDTH 240
	
#define UPPER_ROW_TOP 4
	
	[super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;
	
	if (!self.editing) {
		
		CGFloat boundsX = contentRect.origin.x;
		CGRect newFrame;
		
		// Place the text label
		newFrame = CGRectMake(boundsX + RIGHT_COLUMN_OFFSET, UPPER_ROW_TOP, RIGHT_COLUMN_WIDTH, 13);
		newFrame.origin.y = 15;
		self.todoTextLabel.frame = newFrame;
		
		// Place the priority image
		UIImageView *newImageView = self.todoPriorityImageView;
		newFrame = [newImageView frame];
		newFrame.origin.x = boundsX + LEFT_COLUMN_OFFSET;
		newFrame.origin.y = 10;
		newImageView.frame = newFrame;
		
		// Place the priority label
		CGSize prioritySize = [self.todoPriorityLabel.text sizeWithFont:self.todoPriorityLabel.font forWidth:RIGHT_COLUMN_WIDTH
									lineBreakMode:UILineBreakModeTailTruncation];
		CGFloat priorityX = newFrame.origin.x + newImageView.frame.size.width + 8.0;
		newFrame = CGRectMake(priorityX, UPPER_ROW_TOP, prioritySize.width, prioritySize.height);
		newFrame.origin.y = 15;
		self.todoPriorityLabel.frame = newFrame;
		
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	
	UIColor *newBackgroundColor = nil;
	if (selected) {
		newBackgroundColor = [UIColor clearColor];
	} else {
		newBackgroundColor = [UIColor whiteColor];
	}
	
	self.todoTextLabel.backgroundColor = newBackgroundColor;
	self.todoTextLabel.highlighted = selected;
	self.todoTextLabel.opaque = !selected;
	
	self.todoPriorityLabel.backgroundColor = newBackgroundColor;
	self.todoPriorityLabel.highlighted = selected;
	self.todoPriorityLabel.opaque = !selected;
	
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor
							 fontSize:(CGFloat)fontSize bold:(BOOL)bold {
	UIFont *newFont;
	if (bold) {
		newFont = [UIFont boldSystemFontOfSize:fontSize];
	} else {
		newFont = [UIFont systemFontOfSize:fontSize];
	}
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = newFont;
	
	return newLabel;
}

- (UIImage *)imageForPriority:(NSInteger)priority {
	
	switch (priority) {
		case 2:
			return priorityImage2;
			break;
		case 3:
			return priorityImage3;
			break;
		default:
			return priorityImage1;
			break;
	}
	return nil;
}















@end
