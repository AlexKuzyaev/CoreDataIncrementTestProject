//
//  AKViewControllerPresenter.h
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKViewControllerModel.h"

@protocol AKViewControllerPresenterDelegate

- (void)setButtonPressed:(BOOL)pressed;
- (void)updateData;

@end

@interface AKViewControllerPresenter : NSObject <AKViewControllerModelDelegate>

@property (nonatomic, strong) AKViewControllerModel *model;
@property (nonatomic, weak) id<AKViewControllerPresenterDelegate> delegate;

- (void)buttonTapped;

@end
