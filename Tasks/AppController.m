//
//  AppController.m
//  Tasks
//
//  Created by Chris Mear on 14/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init
{
	[super init];
	tasks = [[NSMutableArray alloc] init];
	return self;
}

- (IBAction)createNewItem:(id)sender
{
	NSString *task = [newItemField stringValue];
	[tasks addObject:task];
	[newItemField setStringValue:@""];
	[tasksTableView reloadData];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [tasks count];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn
row:(int)row
{
	return [tasks objectAtIndex:row];
}

- (void)tableView:(NSTableView *)aTableView
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn
			  row:(NSInteger)rowIndex
{
	[tasks replaceObjectAtIndex:rowIndex withObject:anObject];
	[tasksTableView reloadData];
}
@end
