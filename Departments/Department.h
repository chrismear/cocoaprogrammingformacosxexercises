//
//  Department.h
//  Departments
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Employee;

@interface Department :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * deptName;
@property (nonatomic, retain) NSSet* employees;
@property (nonatomic, retain) Employee * manager;

@end


@interface Department (CoreDataGeneratedAccessors)
- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;

@end

