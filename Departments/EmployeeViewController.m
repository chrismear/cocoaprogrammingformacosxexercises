//
//  EmployeeViewController.m
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "EmployeeViewController.h"


@implementation EmployeeViewController

- (id)init
{
	if (![super initWithNibName:@"EmployeeView" bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Employees"];
	return self;
}

// Take care of the delete key
- (void)keyDown:(NSEvent *)e
{
	if (([e keyCode] == 51) || ([e keyCode] == 117)) {
		[employeeController remove:nil];
	} else {
		[super keyDown:e];
	}
}

@end
