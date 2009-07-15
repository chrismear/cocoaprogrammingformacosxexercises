// 
//  Employee.m
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "Employee.h"


@implementation Employee 

@dynamic lastName;
@dynamic firstName;
@dynamic department;

- (NSString *)fullName
{
	NSString *first = [self firstName];
	NSString *last = [self lastName];
	if (!first)
		return last;
	
	if (!last)
		return first;
	
	return [NSString stringWithFormat:@"%@ %@", first, last];
}

+ (NSSet *)keyPathsForValuesAffectingFullName
{
	return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

@end
