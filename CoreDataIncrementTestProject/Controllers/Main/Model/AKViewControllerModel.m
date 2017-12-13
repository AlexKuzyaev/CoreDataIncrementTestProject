//
//  AKViewControllerModel.m
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import "AKViewControllerModel.h"
#import "AppDelegate.h"

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@implementation AKViewControllerModel {
    NSMutableArray *objectsDatasource;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

#pragma mark - Setup

- (void)setup {
    [self loadDatasource];
}

#pragma mark - Update

- (void)updateDatasource {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (NSManagedObject *number in objectsDatasource) {
        NSInteger value = [[number valueForKey:@"value"] integerValue];
        [number setValue:@(value + 1) forKey:@"value"];
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self updateValueDatasource];
    
    if (self.delegate) {
        [self.delegate dataChanged];
    }
}

- (void)updateData:(NSArray *)array {
    objectsDatasource = [array mutableCopy];
    [self updateValueDatasource];
    if (self.delegate) {
        [self.delegate dataChanged];
    }
}

- (void)updateValueDatasource {
    
    self.datasource = [@[] mutableCopy];
    
    for (int i = 0; i < objectsDatasource.count; i++) {
        NSManagedObject *number = objectsDatasource[i];
        NSNumber *value = [number valueForKey:@"value"];
        if (value != nil) {
            [self.datasource addObject:value];
        }
    }
    
    self.datasource = [[self.datasource sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

#pragma mark - Default

- (void)setDefaultDatasource {
    
    [self deleteAllNumbers];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSArray *defaultData = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10)];
    
    for (int i = 0; i < defaultData.count; i++) {
        NSManagedObject *number = [NSEntityDescription insertNewObjectForEntityForName:@"Number" inManagedObjectContext:context];
        [number setValue:defaultData[i] forKey:@"value"];
    }
    
    NSError *error = nil;

    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self fetchData];
    
    if (self.delegate) {
        [self.delegate dataChanged];
    }
}

- (void)deleteAllNumbers {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Number"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [context.persistentStoreCoordinator executeRequest:delete withContext:context error:&deleteError];
}

#pragma mark - Load

- (void)loadDatasource {
    [self fetchData];
    if (objectsDatasource.count == 0) {
        [self setDefaultDatasource];
    }
}

- (void)fetchData {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Number"];
    [self updateData:[managedObjectContext executeFetchRequest:fetchRequest error:nil]];
}

#pragma mark - Other
                    
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}

@end
