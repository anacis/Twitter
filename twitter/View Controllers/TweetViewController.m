//
//  TweetViewController.m
//  twitter
//
//  Created by Ana Cismaru on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.tweet.user.name);
    [self refreshData];
}

- (void)refreshData {
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profilePicURLString];
       [self.profilePic setImageWithURL:profilePicURL];
       self.nameLabel.text = self.tweet.user.name;
       
       if (self.tweet.user.screenName != nil) {
           NSString *atSym = @"@";
           self.usernameLabel.text = [atSym stringByAppendingString:self.tweet.user.screenName];
       }
       else {
           self.usernameLabel.text = @"";
       }
       
       self.dateLabel.text = self.tweet.createdAtString;
       self.tweetLabel.text = self.tweet.text;
       
       
       if (self.tweet.retweeted) {
           UIImage *img = [UIImage imageNamed:@"retweet-icon-green"];
           [self.retweetButton setImage:img forState:UIControlStateNormal];
       }
       else {
           UIImage *img = [UIImage imageNamed:@"retweet-icon"];
           [self.retweetButton setImage:img forState:UIControlStateNormal];
       }
       
       self.retweetCount.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
       
       if (self.tweet.favorited) {
           UIImage *img = [UIImage imageNamed:@"favor-icon-red"];
           [self.likeButton setImage:img forState:UIControlStateNormal];
       }
       else {
           UIImage *img = [UIImage imageNamed:@"favor-icon"];
           [self.likeButton setImage:img forState:UIControlStateNormal];
       }
       
       self.likeCount.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (IBAction)didTapFavorite:(id)sender {
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        NSString *urlString = @"1.1/favorites/create.json";
        [[APIManager shared] updateTweetStatus:self.tweet urlString:urlString completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        NSString *urlString = @"1.1/favorites/destroy.json";
        [[APIManager shared] updateTweetStatus:self.tweet urlString:urlString completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
        
    }
    
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        NSString *urlString = @"1.1/statuses/retweet.json";
        [[APIManager shared] updateTweetStatus:self.tweet urlString:urlString completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        NSString *urlString = @"1.1/statuses/unretweet.json";
        [[APIManager shared] updateTweetStatus:self.tweet urlString:urlString completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    [self refreshData];
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
