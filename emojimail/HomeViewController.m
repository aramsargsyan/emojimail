//
//  HomeViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/19/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "HomeViewController.h"
#import "MessagesDataSource.h"
#import "MessageTableViewCell.h"
#import "UIView+Autolayout.h"


@interface HomeViewController () <MessagesDataSourceDelegate, UITableViewDelegate>

@property (nonatomic) MessagesDataSource *dataSource;

@property (nonatomic) UITableView *messagesTableView;

@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end


@implementation HomeViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    self.navigationItem.title = [info objectForKey:@"CFBundleDisplayName"];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
    [self configureTableView];
    [self configureActivityIndicator];
}


#pragma mark - Views


- (void)configureTableView {
    self.messagesTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.messagesTableView registerNib:[UINib nibWithNibName:NSStringFromClass(MessageTableViewCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MessageTableViewCell defaultReuseIdentifier]];
    
    self.dataSource = [[MessagesDataSource alloc] init];
    self.messagesTableView.dataSource = self.dataSource;
    self.messagesTableView.delegate = self;
    self.dataSource.delegate = self;
    
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
