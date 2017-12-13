//
//  AKViewControllerPresenter.m
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import "AKViewControllerPresenter.h"

@implementation AKViewControllerPresenter 

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[AKViewControllerModel alloc] init];
        self.model.delegate = self;
        [self.model setup];
        [self updateView];
    }
    return self;
}

- (void)dataChanged {
    [self updateView];
}

- (void)updateView {
    if (self.delegate) {
        [self.delegate updateData];
        [self.delegate setButtonPressed:false];
    }
}

- (void)buttonTapped {
    if (self.delegate) {
        [self.delegate setButtonPressed:true];
    }
    [self.model updateDatasource];
}

@end
