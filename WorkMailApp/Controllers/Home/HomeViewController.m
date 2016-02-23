//
//  HomeViewController.m
//  WorkMailApp
//
//  Created by Kirill Ushkov on 23/02/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "HomeViewController.h"
#import "MailTextComposerViewController.h"

@implementation HomeViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [MailTextComposerViewController class]]) {
        NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selected];
        
        MailTextComposerViewController *vc = (MailTextComposerViewController*)segue.destinationViewController;
        vc.mailCaseType = selected.row;
        vc.title = cell.textLabel.text;
    }
}

@end
