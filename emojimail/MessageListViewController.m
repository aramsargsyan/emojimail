//
//  MessageListViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessagesDataSource.h"
#import "MessageTableViewCell.h"
#import "UIView+Autolayout.h"
#import "MessageTableViewCell.h"
#import "MessageItem.h"


@interface MessageListViewController () <UITableViewDelegate, UITableViewDataSource> //MessagesDataSourceDelegate

//@property (nonatomic) MessagesDataSource *dataSource;

@property (nonatomic) UITableView *messagesTableView;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic) NSArray<MessageItem *> *messageItems;

@end


@implementation MessageListViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureNavigationBar];
    [self configureTableView];
    [self configureActivityIndicator];
    
    [self.eventHandler updateTableView];
}


#pragma mark - Views

- (void)configureNavigationBar {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    self.navigationItem.title = [info objectForKey:@"CFBundleDisplayName"];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

- (void)configureTableView {
    self.messagesTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.messagesTableView registerNib:[UINib nibWithNibName:NSStringFromClass(MessageTableViewCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MessageTableViewCell defaultReuseIdentifier]];
    
    self.messagesTableView.hidden = YES;
    
    [self.view addSubview:self.messagesTableView];
    self.messagesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.messagesTableView autopinEdgesToSuperview];
}


- (void)configureActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.activityIndicator autocenterInSuperview];
    [self.activityIndicator startAnimating];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageTableViewCell defaultReuseIdentifier] forIndexPath:indexPath];
    
    // Request for the next page when the user reaches last 10 messages
    if ((indexPath.row == self.messageItems.count - 10)) {// && !self.requestInProcess) {
        //[self requestForMessagesList];
        
        //TODO: ARAM presenteeeer
    }
    
    [cell renderMessageItem:self.messageItems[indexPath.row]];
    
    return cell;
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MessageTableViewCell defaultCellHeight];
}


#pragma mark - MessagesDataSourceDelegate


- (void)refresh {
    [self.messagesTableView reloadData];
    self.messagesTableView.hidden = NO;
    [self.activityIndicator stopAnimating];
}


@end
