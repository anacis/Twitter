//
//  ComposeViewController.m
//  twitter
//
//  Created by Ana Cismaru on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *charLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    [self getProfileData];
    // Do any additional setup after loading the view.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update Character Count Label
    NSUInteger num = (140 - newText.length);
    NSString *charLeft = [NSString stringWithFormat:@"%lu", num];
    if (num > 0) {
        self.charLeftLabel.text = [charLeft stringByAppendingString:@" characters left"];
    } else {
        self.charLeftLabel.text = @"Maximum characters exceeded";
    }
    
    

    // The new text should be allowed? True/False
    return newText.length < characterLimit;
}


- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)postTweet:(id)sender {
    NSString *text = self.textView.text;
    [[APIManager shared] postStatusWithText:text completion:^(Tweet *tweet, NSError *error) {
        if (error != nil) {
            [self.delegate didTweet:tweet];
            NSLog(@"😎😎😎 Successfully posted Tweet");
        } else {
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
        [self dismissViewControllerAnimated:true completion:nil];
        
    }];
}
- (void)getProfileData {
    [[APIManager shared] getMyUserProfileData:^(User *user, NSError *error) {
        if (error == nil) {
            //self.tweets = (NSMutableArray *) tweets;
            NSLog(@"Got my user data!");
            self.user = user;
            [self setUpProfile];
        } else {
            NSLog(@"😫😫😫 Error getting my user data: %@", error.localizedDescription);
        }
    }];
}

- (void)setUpProfile {
    NSURL *profilePicURL = [NSURL URLWithString:self.user.profilePicURLString];
    [self.profilePic setImageWithURL:profilePicURL];
    
    self.nameLabel.text = self.user.name;
    
    if (self.user.screenName != nil) {
        NSString *atSym = @"@";
        self.usernameLabel.text = [atSym stringByAppendingString:self.user.screenName];
    }
    else {
        self.usernameLabel.text = @"";
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
