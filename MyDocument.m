//
//  MyDocument.m
//  RaiseMan
//
//  Created by Chris Mear on 16/03/2009.
//  Copyright Greenvoice 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "Person.h"
#import "PreferenceController.h"

@implementation MyDocument

- (id)init
{
	if (![super init]) {
		return nil;
	}
	
	employees = [[NSMutableArray alloc] init];
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self
		   selector:@selector(handleColorChange:)
			   name:BNRColorChangedNotification
			 object:nil];
	NSLog(@"Registered with notification center");
	
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *colorAsData;
	colorAsData = [defaults objectForKey:BNRTableBgColorKey];
	[tableView setBackgroundColor:[NSKeyedUnarchiver unarchiveObjectWithData:colorAsData]];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	// End editing
	[[tableView window] endEditingFor:nil];
	
	// create an NSData object from the employees array
	return [NSKeyedArchiver archivedDataWithRootObject:employees];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"About to read data of type %@", typeName);
	NSMutableArray *newArray = nil;
	@try {
		newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	@catch (NSException *e) {
		if (outError) {
			NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted."
														  forKey:NSLocalizedFailureReasonErrorKey];
			*outError = [NSError errorWithDomain:NSOSStatusErrorDomain
											code:unimpErr
										userInfo:d];
		}
		return NO;
	}
	
	[self setEmployees:newArray];
	return YES;
}

- (void)setEmployees:(NSMutableArray *)a
{
	if (a==employees)
		return;
	
	for (Person *person in employees) {
		[self stopObservingPerson:person];
	}
	
	[a retain];
	[employees release];
	employees = a;
	for (Person *person in employees) {
		[self startObservingPerson:person];
	}
}

- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index
{
	NSLog(@"adding %@ to %@", p, employees);
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self]
	  removeObjectFromEmployeesAtIndex:index];
	if (![undo isUndoing]) {
		[undo setActionName:@"Insert Person"];
	}
	[self startObservingPerson:p];
	[employees insertObject:p atIndex:index];
}

- (void)removeObjectFromEmployeesAtIndex:(int)index
{
	Person *p = [employees objectAtIndex:index];
	NSLog(@"removeing %@ from %@", p, employees);
	NSUndoManager *undo = [self undoManager];
	[[undo prepareWithInvocationTarget:self] insertObject:p
									   inEmployeesAtIndex:index];
	if (![undo isUndoing]) {
		[undo setActionName:@"Delete Person"];
	}
	[self stopObservingPerson:p];
	[employees removeObjectAtIndex:index];
}

- (void)startObservingPerson:(Person *)person
{
	[person addObserver:self
			 forKeyPath:@"personName"
				options:NSKeyValueObservingOptionOld
				context:NULL];
	
	[person addObserver:self
			 forKeyPath:@"expectedRaise"
				options:NSKeyValueObservingOptionOld
				context:NULL];
}

- (void)stopObservingPerson:(Person *)person
{
	[person removeObserver:self forKeyPath:@"personName"];
	[person removeObserver:self forKeyPath:@"expectedRaise"];
}

- (void)changeKeyPath:(NSString *)keyPath
             ofObject:(id)obj
              toValue:(id)newValue
{
	[obj setValue:newValue forKeyPath:keyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
ofObject:(id)object
change:(NSDictionary *)change
context:(void *)context
{
	NSUndoManager *undo = [self undoManager];
	id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
	if (oldValue == [NSNull null]) {
		oldValue = nil;
	}
	NSLog(@"oldValue = %@", oldValue);
	[[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
												  ofObject:object
												   toValue:oldValue];
	[undo setActionName:@"Edit"];
}

- (IBAction)createEmployee:(id)sender
{
	NSWindow *w = [tableView window];
	
	BOOL editingEnded = [w makeFirstResponder:w];
	if (!editingEnded) {
		NSLog(@"Unable to end editing");
		return;
	}
	NSUndoManager *undo = [self undoManager];
	
	if ([undo groupingLevel]) {
		[undo endUndoGrouping];
		[undo beginUndoGrouping];
	}
	
	Person *p = [employeeController newObject];
	
	[employeeController addObject:p];
	[p release];
	[employeeController rearrangeObjects];
	
	NSArray *a = [employeeController arrangedObjects];
	
	int row = [a indexOfObjectIdenticalTo:p];
	NSLog(@"starting edit of %@ in row %d", p, row);
	
	[tableView editColumn:0
					  row:row
				withEvent:nil
				   select:YES];
}

- (void)handleColorChange:(NSNotification *)note{
	NSLog(@"Received notification: %@", note);
	NSColor *color = [[note userInfo] objectForKey:@"color"];
	[tableView setBackgroundColor:color];
}


- (void)dealloc
{
	[self setEmployees:nil];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self];
	[super dealloc];
}

@end
