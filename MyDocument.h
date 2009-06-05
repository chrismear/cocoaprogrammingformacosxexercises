//
//  MyDocument.h
//  RaiseMan
//
//  Created by Chris Mear on 16/03/2009.
//  Copyright Greenvoice 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray *employees;
	IBOutlet NSTableView *tableView;
	IBOutlet NSArrayController *employeeController;
}
- (void)setEmployees:(NSMutableArray *)a;
- (void)removeObjectFromEmployeesAtIndex:(int)index;
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
- (IBAction)createEmployee:(id)sender;
- (void)startObservingPerson:(Person *)person;
- (void)stopObservingPerson:(Person *)person;
@end
