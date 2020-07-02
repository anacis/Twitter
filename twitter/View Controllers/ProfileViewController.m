//
//  ProfileViewController.m
//  twitter
//
//  Created by Ana Cismaru on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberSinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.user == nil) {
        [self getProfileData];
    } else {
        [self setUpProfile];
    }
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.user == nil) {
        [self getProfileData];
    } else {
        [self setUpProfile];
    }
    
}

- (void)getProfileData {
    [[APIManager shared] getMyUserProfileData:^(User *user, NSError *error) {
        if (error == nil) {
            //self.tweets = (NSMutableArray *) tweets;
            NSLog(@"Got my user data!");
            self.user = user;
            [self setUpProfile];
        } else {
            NSLog(@"😫😫😫 Error my profile data: %@", error.localizedDescription);
        }
    }];
}

- (void)setUpProfile {
    NSURL *profilePicURL = [NSURL URLWithString:self.user.profilePicURLString];
    [self.profileImage setImageWithURL:profilePicURL];
    
    NSURL *bannerPicURL = [NSURL URLWithString:self.user.bannerPicURLString];
    [self.bannerImage setImageWithURL:bannerPicURL];
    
    self.nameLabel.text = self.user.name;
    
    if (self.user.screenName != nil) {
        NSString *atSym = @"@";
        self.usernameLabel.text = [atSym stringByAppendingString:self.user.screenName];
    }
    else {
        self.usernameLabel.text = @"";
    }
    
    self.taglineLabel.text = self.user.tagline;
    
    self.followerCount.text = self.user.followerCount;
    
    self.followingCount.text = self.user.followingCount;
    
    self.tweetCount.text = self.user.tweetCount;
    
    self.memberSinceLabel.text = self.user.memberSince;
    
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
