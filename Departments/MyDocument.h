//
//  MyDocument.h
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright Greenvoice 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ManagingViewController;

@interface MyDocument : NSPersistentDocument {
	IBOutlet NSBox *box;
	IBOutlet NSPopUpButton *popUp;
	NSMutableArray *viewControllers;
}

- (IBAction)changeViewController:(id)sender;
- (void)displayViewController:(ManagingViewController *)vc;

@end
