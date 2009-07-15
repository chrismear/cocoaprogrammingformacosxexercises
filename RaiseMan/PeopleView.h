//
//  PeopleView.h
//  RaiseMan
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PeopleView : NSView {
	NSArray *people;
	NSMutableDictionary *attributes;
	float lineHeight;
	NSRect pageRect;
	int linesPerPage;
	int currentPage;
}
- (id)initWithPeople:(NSArray *)array;
@end
