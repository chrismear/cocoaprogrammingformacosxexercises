//
//  DepartmentViewController.m
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "DepartmentViewController.h"


@implementation DepartmentViewController

- (id)init
{
	if (![super initWithNibName:@"DepartmentView"
						 bundle:nil]) {
		return nil;
	}
	[self setTitle:@"Departments"];
	return self;
}

@end
