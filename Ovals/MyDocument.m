//
//  MyDocument.m
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright Greenvoice 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "Oval.h"

@implementation MyDocument

- (id)init
{
	if (![super init]) {
		return nil;
	}
	
	ovals = [[NSMutableArray alloc] init];
	
	return self;
}

- (NSString *)windowNibName {
    return @"MyDocument";
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	NSLog(@"Archiving");
	return [NSKeyedArchiver archivedDataWithRootObject:ovals];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
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
	[self setOvals:newArray];
    return YES;
}

- (NSMutableArray *)ovals
{
	NSLog(@"ovals requested");
	return ovals;
}

- (void)setOvals:(NSMutableArray *)newOvals
{
	if (newOvals == ovals) {
		return;
	}
	[newOvals retain];
	[ovals release];
	ovals = newOvals;
}

- (void)createOval:(Oval *)newOval
{
	NSLog(@"adding new oval");
	[ovals addObject:newOval];
	
	[self updateChangeCount:NSChangeDone];
}
@end
