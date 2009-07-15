//
//  Employee.h
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Department;

@interface Employee :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSManagedObject * department;
@property (readonly) NSString *fullName;

@end



