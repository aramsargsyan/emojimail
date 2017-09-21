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


@interface HomeViewController () <MessagesDataSourceDelegate, UITableViewDelegate>

@property (nonatomic) MessagesDataSource *dataSource;

@property (nonatomic) UITableView *messagesTableView;

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
}


#pragma mark - Views


- (void)configureTableView {
    self.messagesTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.messagesTableView registerNib:[UINib nibWithNibName:NSStringFromClass(MessageTableViewCell.class) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MessageTableViewCell defaultReuseIdentifier]];
    
    self.dataSource = [[MessagesDataSource alloc] init];
    self.messagesTableView.dataSource = self.dataSource;
    self.messagesTableView.delegate = self;
    self.dataSource.delegate = self;
    
    [self.view addSubview:self.messagesTableView];
    self.messagesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.messagesTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.messagesTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.messagesTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.messagesTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}


#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MessageTableViewCell defaultCellHeight];
}


#pragma mark - MessagesDataSourceDelegate


- (void)refresh {
    [self.messagesTableView reloadData];
}


@end
