//
//  AppController.h
//  Tasks
//
//  Created by Chris Mear on 14/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *newItemField;
	IBOutlet NSTableView *tasksTableView;
	NSMutableArray *tasks;
}
- (IBAction)createNewItem:(id)sender;
@end
