//
//  AKViewControllerModel.h
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol AKViewControllerModelDelegate

- (void)dataChanged;

@end

@interface AKViewControllerModel : NSObject

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, weak) id<AKViewControllerModelDelegate> delegate;

- (void)setup;
- (void)updateDatasource;

@end
