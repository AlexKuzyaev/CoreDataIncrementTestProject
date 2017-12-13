//
//  AKViewController.m
//  TestProject
//
//  Created by Александр Кузяев on 26.11.17.
//  Copyright © 2017 Alexandr Kuzyaev. All rights reserved.
//

#import "AKViewController.h"

NSString * const reuseIdentifier = @"TableViewCell";

@interface AKViewController () <UIGestureRecognizerDelegate>

@end

@implementation AKViewController {
    UIGestureRecognizer *recognizer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.presenter = [[AKViewControllerPresenter alloc] init];
    self.presenter.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConstraints];
    [self configureViews];
}

- (void)setupConstraints {
    self.tableViewHeight.constant = self.view.frame.size.height / 3 * 2;
    self.buttonHeight.constant = self.view.frame.size.height / 2;
}

- (void)configureViews {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    recognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}

- (void)handlePan:(UITapGestureRecognizer *)recognizer { }

#pragma mark - TableViewController Delegate/Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.presenter.model.datasource[indexPath.item]];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter.model.datasource count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height / 10;
}

#pragma mark - Datasource

- (void)datasourceUpdated {
    [self.button buttonPressed:false];
}

#pragma mark - Gestures

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL touchInTableView = [self touch:touch inView:self.tableView];
    BOOL touchInButton = [self touch:touch inView:self.button];
    
    if (touchInButton && !touchInTableView) {
        [self.presenter buttonTapped];
    }
    
    return true;
}

- (BOOL)touch:(UITouch *)touch inView:(UIView *)view {
    CGPoint point = [touch locationInView:touch.view];
    CGPoint pointInView = [touch.view convertPoint:point toView:view];
    return CGRectContainsPoint(view.bounds, pointInView);
}

#pragma mark - AKViewControllerPresenterDelegate

- (void)setButtonPressed:(BOOL)pressed {
    [self.button buttonPressed:pressed];
}

- (void)updateData {
    [self.tableView reloadData];
}

#pragma mark - Other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
