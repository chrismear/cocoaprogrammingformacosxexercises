//
//  ManagingViewController.m
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "ManagingViewController.h"


@implementation ManagingViewController

@synthesize managedObjectContext;

- (void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}

@end
