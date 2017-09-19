//
//  ViewController.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/18/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "ViewController.h"
#import "AuthentificationViewController.h"

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // Create a UITextView to display output.
    self.output = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.output.editable = false;
    self.output.contentInset = UIEdgeInsetsMake(20.0, 0.0, 20.0, 0.0);
    self.output.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.output.hidden = true;
    [self.view addSubview:self.output];
    
    // Initialize the service object.
    self.service = [[GTLRGmailService alloc] init];
}


#pragma mark - Private

// Construct a query and get a list of labels from the user's gmail. Display the
// label name in the UITextView
- (void)fetchLabels {
    self.output.text = @"Getting labels...";
    
    //first query example
    /*GTLRGmailQuery_UsersLabelsList *query = [GTLRGmailQuery_UsersLabelsList queryWithUserId:@"me"];*/
    
    //list with no content
    GTLRGmailQuery_UsersMessagesList *query = [GTLRGmailQuery_UsersMessagesList queryWithUserId:@"me"];
    query.includeSpamTrash = NO;
    query.maxResults = 10;
    query.pageToken = 0;
    query.labelIds = nil;
    
    //query.q = @"rfc822msgid: is:unread";
    [self.service executeQuery:query
                      delegate:self
             didFinishSelector:@selector(displayResultWithTicket:finishedWithObject:error:)];
    
    //GTLRGmailQuery_UsersMessagesGet *query = [GTLRGmailQuery_UsersMessagesGet queryWithUserId:@"me" identifier:@""];
    
    
}




/*- (void)displayResultWithTicket:(GTLRServiceTicket *)ticket
 finishedWithObject:(GTLRGmail_ListLabelsResponse *)labelsResponse
 error:(NSError *)error {
 if (error == nil) {
 NSMutableString *labelString = [[NSMutableString alloc] init];
 if (labelsResponse.labels.count > 0) {
 [labelString appendString:@"Labels:\n"];
 for (GTLRGmail_Label *label in labelsResponse.labels) {
 [labelString appendFormat:@"%@\n", label.name];
 }
 } else {
 [labelString appendString:@"No labels found."];
 }
 self.output.text = labelString;
 } else {
 [self showAlert:@"Error" message:error.localizedDescription];
 }
 }*/

- (void)displayResultWithTicket:(GTLRServiceTicket *)ticket
             finishedWithObject:(GTLRGmail_ListMessagesResponse *)messagesResponse
                          error:(NSError *)error {
    
    for (GTLRGmail_Message *message in messagesResponse.messages) {
        NSLog(@"%@", message);
        NSLog(@"response %li", [messagesResponse.messages indexOfObject:message]);
    }
    
    
}







@end
