//
//  AKViewController.h
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKViewControllerPresenter.h"
#import "AKIncrementButton.h"

@interface AKViewController : UIViewController <AKViewControllerPresenterDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AKViewControllerPresenter *presenter;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic, weak) IBOutlet AKIncrementButton *button;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonHeight;

- (void)setButtonPressed:(BOOL)pressed;

@end
