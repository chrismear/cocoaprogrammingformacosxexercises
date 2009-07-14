//
//  MyDocument.h
//  RaiseManual
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
}
- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployees:(id)sender;
@end
