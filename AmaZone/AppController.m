//
//  AppController.m
//  AmaZone
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "AppController.h"
#import <WebKit/WebKit.h>

#define AWS_ID @"AKIAIQGTJS35BBAEF42A"

@implementation AppController

- (IBAction)fetchBooks:(id)sender
{
	[progress startAnimation:nil];
	
	NSString *input = [searchField stringValue];
	NSString *searchString = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"searchString = %@", searchString);
	
	NSString *urlString = [NSString stringWithFormat:
						   @"http://ecs.amazonaws.com/onca/xml?"
						   @"Service=AWSECommerceService&"
						   @"AWSAccessKeyId=%@&"
						   @"Operation=ItemSearch&"
						   @"SearchIndex=Books&"
						   @"Keywords=%@&"
						   @"Version=2007-07-16",
						   AWS_ID, searchString];
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
												cachePolicy:NSURLRequestReturnCacheDataElseLoad
											timeoutInterval:30];
	
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
									returningResponse:&response
												error:&error];
	
	if (!urlData) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	[doc release];
	doc = [[NSXMLDocument alloc] initWithData:urlData
									  options:0
										error:&error];
	NSLog(@"doc = %@", doc);
	if (!doc) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	
	[itemNodes release];
	itemNodes = [[doc nodesForXPath:@"ItemSearchResponse/Items/Item"
							  error:&error] retain];
	if (!itemNodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return;
	}
	[tableView reloadData];
	[progress stopAnimation:nil];
}

- (NSString *)stringForPath:(NSString *)xp ofNode:(NSXMLNode *)n
{
	NSError *error;
	NSArray *nodes = [n nodesForXPath:xp error:&error];
	if (!nodes) {
		NSAlert *alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	if ([nodes count] == 0) {
		return nil;
	} else {
		return [[nodes objectAtIndex:0] stringValue];
	}
}

#pragma mark TableView data source methods

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [itemNodes count];
}

- (id)tableView:(NSTableView *)tv
	objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(int)row
{
	NSXMLNode *node = [itemNodes objectAtIndex:row];
	NSString *xPath = [tableColumn identifier];
	return [self stringForPath:xPath ofNode:node];
}

- (void)awakeFromNib
{
	[tableView setDoubleAction:@selector(openItem:)];
	[tableView setTarget:self];
}

- (void)openItem:(id)sender
{
	int row = [tableView clickedRow];
	if (row == -1) {
		return;
	}
	NSXMLNode *clickedItem = [itemNodes objectAtIndex:row];
	NSString *urlString = [self stringForPath:@"DetailPageURL" ofNode:clickedItem];
	
	[webView setMainFrameURL:urlString];
	
	// Show web sheet
	[NSApp beginSheet:webSheet
	   modalForWindow:mainWindow
		modalDelegate:nil
	   didEndSelector:NULL
		  contextInfo:NULL];
}

- (IBAction)endWebSheet:(id)sender
{
	[NSApp endSheet:webSheet];
	[webSheet orderOut:sender];
}

@end
