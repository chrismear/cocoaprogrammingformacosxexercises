//
//  AppController.h
//  AmaZone
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSProgressIndicator *progress;
	IBOutlet NSTextField *searchField;
	IBOutlet NSTableView *tableView;
	
	NSXMLDocument *doc;
	NSArray *itemNodes;
}

- (IBAction)fetchBooks:(id)sender;

@end
